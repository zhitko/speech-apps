#include "speechcontroller.h"
#include <QDebug>

#include "defines.h"

#include "filecontroller.h"

#include "services/Google/googlespeech.h"
#include "services/tts/tts.h"

#include "utills/singleton.h"

#include "system/settingsvalult.h"

SpeechController::SpeechController(QObject *parent) : QObject(parent)
{
    qDebug() << "SpeechController::SpeechController";

    this->tts = &Singleton<TTS>::Instance();
    connect(this->tts, &TTS::finished, [=](){
        emit this->finishSpeaking();
    });
}

SpeechController::~SpeechController()
{
    qDebug() << "SpeechController::~SpeechController";
}

void SpeechController::recognizeFile(QString file)
{
    qDebug() << "SpeechController::recognizeFile >> " << file;
    QString filePath = FileController::getUserFilesDir() + file;
    GoogleSpeech * googleSpeech = new GoogleSpeech();
    connect(googleSpeech, &GoogleSpeech::getText, [=](QString text){
        emit this->recognized(file, text.split("\n"));
    });
    googleSpeech->sent(filePath);
}

void SpeechController::synthesize(QString text)
{
    qDebug() << "SpeechController::synthesize >> " << text;
    SettingsValult * settingsValult = &Singleton<SettingsValult>::Instance();
    this->tts->setVoice(settingsValult->getTtsVoice());
//    this->tts->tell(text);
    this->tts->say(text);
}
