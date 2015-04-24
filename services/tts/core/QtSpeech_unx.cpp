/*  QtSpeech -- a small cross-platform library to use TTS
    Copyright (C) 2010-2011 LynxLine.

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 3 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General
    Public License along with this library; if not, write to the
    Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301 USA */

#include <QtCore>
#include "QtSpeech.h"
#include "QtSpeech_unx.h"
#include "festival.h"

#include <QDebug>

// some defines for throwing exceptions
#define Where QString("%1:%2:").arg(__FILE__).arg(__LINE__)
#define SysCall(x,e) \
    {\
    int ok = x;\
    if (!ok) \
    {\
        QString msg = #e;\
        msg += ":"+QString(__FILE__);\
        msg += ":"+QString::number(__LINE__)+":"+#x;\
        throw e(msg);\
    }\
}

// qobject for speech thread
bool QtSpeech_th::init = false;

QtSpeech_th::QtSpeech_th(QObject * p)
    :QObject(p), has_error(false), err(""), language("")
{}

QtSpeech_th::QtSpeech_th(const QString language, QObject * p)
    :QObject(p), has_error(false), err(""), language(language)
{}

void QtSpeech_th::initFestival()
{
    if (!init)
    {
        try
        {
            qDebug() << "QtSpeech_th::initFestival";
            int heap_size = FESTIVAL_HEAP_SIZE;
            festival_initialize(true, heap_size);
            init = true;

            EST_String get_langs(QString("(language.list)").toUtf8());
            LISP lGetLangs = read_from_string((char *)get_langs);
            LISP lLangs = leval(lGetLangs,NIL);
            for(int i=0; i<siod_llength(lLangs); i++)
                this->languages.append(QString(get_c_string(siod_nth(i, lLangs))));
            qDebug() << "QtSpeech_th::initFestival >> " << this->languages;
            has_error = false;
        }
        catch(QtSpeech::LogicError e)
        {
            has_error = true;
            err = e;
        }
    }

    if(language.length() > 0)
    {
        EST_String estLanguage(language.toUtf8());
        festival_init_lang(estLanguage);
    }
}

void QtSpeech_th::say(const QString text)
{
    initFestival();
    qDebug() << "QtSpeech_th::say >> " << text << " " << languages;
    try
    {
        has_error = false;
        EST_String est_text(text.toUtf8());
        SysCall(festival_say_text(est_text), QtSpeech::LogicError);
    }
    catch(QtSpeech::LogicError e)
    {
        has_error = true;
        err = e;
    }
    emit finished();
}

QStringList QtSpeech_th::getLanguages()
{
    initFestival();
    return this->languages;
}

// internal data
class QtSpeech::Private
{
public:
    Private()
        :onFinishSlot(0L) {}

    VoiceName name;
    static const QString VoiceId;

    const char * onFinishSlot;
    QPointer<QObject> onFinishObj;
    static QPointer<QThread> speechThread;
};
QPointer<QThread> QtSpeech::Private::speechThread = 0L;
const QString QtSpeech::Private::VoiceId = QString("%1");

// implementation
QtSpeech::QtSpeech(QObject * parent)
    :QObject(parent), d(new Private)
{
    // TODO: change default to first in list of languages
    VoiceName n = {Private::VoiceId.arg("english"), "English"};
    if (n.id.isEmpty())
        throw InitError(Where+"No default voice in system");

    d->name = n;
}

QtSpeech::QtSpeech(VoiceName n, QObject * parent)
    :QObject(parent), d(new Private)
{
    if (n.id.isEmpty()) {
        // TODO: change default to first in list of languages
        VoiceName def = {Private::VoiceId.arg("english"), "English"};
        n = def;
    }

    if (n.id.isEmpty())
        throw InitError(Where+"No default voice in system");

    d->name = n;
}

QtSpeech::~QtSpeech()
{
    //if ()
    delete d;
}

const QtSpeech::VoiceName & QtSpeech::name() const
{
    return d->name;
}

const QtSpeech::VoiceNames QtSpeech::voices()
{
    if (!d->speechThread) {
        d->speechThread = new QThread;
        d->speechThread->start();
    }

    QtSpeech_th th;
    th.moveToThread(d->speechThread);

    VoiceNames vs;
    QStringList list;
    QMetaObject::invokeMethod(&th, "getLanguages", Qt::BlockingQueuedConnection, Q_RETURN_ARG(QStringList, list));
    qDebug() << "QtSpeech::voices " << list;
    if (th.has_error)
        throw th.err;
    foreach(QString lang, th.getLanguages())
    {
        VoiceName n = {
            Private::VoiceId.arg(lang)
            , lang.replace(0, 1, lang[0].toUpper()).replace("_", " ")
        };
        vs << n;
    }

    return vs;
}

void QtSpeech::tell(QString text) const
{
    tell(text, 0L,0L);
}

void QtSpeech::tell(QString text, QObject * obj, const char * slot) const
{
    qDebug() << "QtSpeech::tell >> " << text;

    if (!d->speechThread) {
        d->speechThread = new QThread;
        d->speechThread->start();
    }

    d->onFinishObj = obj;
    d->onFinishSlot = slot;
    if (obj && slot)
        connect(const_cast<QtSpeech *>(this), SIGNAL(finished()), obj, slot);

    QtSpeech_th * th = new QtSpeech_th(d->name.id);
    th->moveToThread(d->speechThread);
    connect(th, SIGNAL(finished()), this, SIGNAL(finished()), Qt::QueuedConnection);
    connect(th, SIGNAL(finished()), th, SLOT(deleteLater()), Qt::QueuedConnection);
    QMetaObject::invokeMethod(th, "say", Qt::QueuedConnection, Q_ARG(QString,text));
}

void QtSpeech::say(QString text) const
{
    qDebug() << "QtSpeech::say >> " << text;
    if (!d->speechThread) {
        d->speechThread = new QThread;
        d->speechThread->start();
    }

    QEventLoop el;
    QtSpeech_th th(d->name.id);
    th.moveToThread(d->speechThread);
    connect(&th, SIGNAL(finished()), &el, SLOT(quit()), Qt::QueuedConnection);
    QMetaObject::invokeMethod(&th, "say", Qt::QueuedConnection, Q_ARG(QString,text));
    el.exec();

    if (th.has_error)
        throw th.err;
}

void QtSpeech::timerEvent(QTimerEvent * te)
{
    QObject::timerEvent(te);
}
