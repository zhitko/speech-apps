#include "tts.h"
#include <QtCore/QDebug>

#include "utills/singleton.h"

TTS::TTS(QObject *parent) :
    QObject(parent), voice("")
{
    qDebug() << "TTS::TTS";

    speech = &Singleton<QtSpeech>::Instance();

    connect(speech, &QtSpeech::finished, [=](){
        qDebug() << "TTS::tell|say Finish";
        emit this->finished();
    });

    QtSpeech::VoiceNames voices = speech->voices();
    foreach(QtSpeech::VoiceName v, voices){
        qDebug() << "TTS::TTS >> id:" << v.id << "name:" << v.name;
        this->voices[v.name] = v;
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
    qDebug() << "TTS::setVoice >> " << voice;
    if (this->voices.contains(voice) && voice != this->voice)
    {
        speech->setVoice(this->voices[voice]);
        this->voice = voice;
    }
}

void TTS::tell(QString data)
{
    qDebug() << "TTS::tell >> " << data << "using voice:" << speech->name().name;
    speech->tell(data);
}

void TTS::say(QString data)
{
    qDebug() << "TTS::say >> " << data << "using voice:" << speech->name().name;
    speech->say(data);
}
