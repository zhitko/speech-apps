#include "translatecontroller.h"

#include <QDebug>

#include "services/TranslateService/translateservice.h"
#include "services/TranslateService/Google/googletranslateconfig.h"
#include "services/TranslateService/Google/googletranslateservice.h"

#include "models/localeobject.h"

TranslateController::TranslateController(QObject *parent) : QObject(parent)
{
    translateService = &GoogleTranslateProvider::Instance(&GoogleTranslateConfigProvider::Instance());
    connect(translateService, &TranslateService::translated, [=](const QString &tr) {
        qDebug() << "TranslateController::translated " << tr;
        emit translated(tr);
    } );
}

TranslateController::~TranslateController()
{

}

void TranslateController::translate(QString text, QString from, QString to)
{
    translateService->translate(text, from, to);
}

QList<QObject *> TranslateController::getLanguageList()
{
    QList<LocaleObject *> * list = new QList<LocaleObject *>();
    list->append(new LocaleObject(new QLocale(QLocale::Russian, QLocale::Russia)));
    list->append(new LocaleObject(new QLocale(QLocale::English, QLocale::UnitedStates)));
    list->append(new LocaleObject(new QLocale(QLocale::Belarusian, QLocale::Belarus)));
    QList<QObject *> * objects = reinterpret_cast<QList<QObject *> * >(list);
    return *objects;
}
