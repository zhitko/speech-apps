#include "tts.h"
#include <QtCore/QDebug>

#include "utills/singleton.h"

TTS::TTS(QObject *parent) :
    QObject(parent), voice("")
{
    qDebug() << "TTS::TTS";

    QtSpeech speech;

    QtSpeech::VoiceNames voices = speech.voices();
//    qDebug() << "TTS::TTS >> " << voices.length();
    foreach(QtSpeech::VoiceName v, voices){
//        qDebug() << "TTS::TTS >> id:" << v.id << "name:" << v.name;
        this->voices[v.name] = v;
        this->voice = v.name;
    }
}

TTS::~TTS()
{
}

QStringList TTS::getVoiceList()
{
    return this->voices.keys();
}

void TTS::setVoice(QString voice)
{
    if (this->voices.contains(voice))
    {
        this->voice = voice;
    }
}

QtSpeech * TTS::getSpeech()
{
    QtSpeech * speech;
    if(this->voice.length() == 0)
        speech = new QtSpeech(this);
    else
        speech = new QtSpeech(this->voices[this->voice], this);
    return speech;
}

void TTS::tell(QString data)
{
    QtSpeech * speech = this->getSpeech();
    qDebug() << "TTS::tell >> " << data << "using voice:" << speech->name().name;

    connect(speech, &QtSpeech::finished, [=](){
        speech->deleteLater();
//        emit this->finished();
    });

    speech->tell(data);
}

void TTS::say(QString data)
{
    QtSpeech * speech = this->getSpeech();
    qDebug() << "TTS::say >> " << data << "using voice:" << speech->name().name;
    speech->say(data);
//    speech->deleteLater();
    qDebug() << "TTS::say Finish";
}
