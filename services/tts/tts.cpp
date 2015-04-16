#include "tts.h"
#include <QtCore/QDebug>

#include "./core/QtSpeech.h"

TTS::TTS(QObject *parent) :
    QObject(parent)
{
    QtSpeech::VoiceName voice = QtSpeech::voices().first();
    foreach(QtSpeech::VoiceName v, QtSpeech::voices()){
        qDebug() << "id:" << v.id << "name:" << v.name;
        if(v.name=="Boris Lobanov") voice = v;
    }
    qDebug() << "create tts:" << voice.name;
    this->speech = new QtSpeech(voice);
    connect(this->speech, SIGNAL(finished()), this, SLOT(_finished()));
}

TTS::~TTS(){
    delete this->speech;
}

void TTS::tell(QString data){
    qDebug() << "TTS::tell >> " << data << "using voice:" << speech->name().name;
    speech->tell(data);
    qDebug() << "TTS::say Finish";
}

void TTS::say(QString data){
    qDebug() << "TTS::say >> " << data << "using voice:" << speech->name().name;
    speech->say(data);
}

void TTS::_finished()
{
    emit finished();
}
