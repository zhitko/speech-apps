#include "speechcontroller.h"
#include <QDebug>

#include "defines.h"

#include "filecontroller.h"

#include "services/Google/googlespeech.h"
#include "services/tts/tts.h"

#include "utills/singleton.h"

#include "models/localeobject.h"

#include "system/settingsvalult.h"

SpeechController::SpeechController(QObject *parent) : QObject(parent)
{
    qDebug() << "SpeechController::SpeechController";

    TTS * tts = &Singleton<TTS>::Instance();
    connect(tts, &TTS::finished, [=](){
        emit this->finishSpeaking();
    });
}

SpeechController::~SpeechController()
{
    qDebug() << "SpeechController::~SpeechController";
}

void SpeechController::recognizeFile(const QString file)
{
    qDebug() << "SpeechController::recognizeFile >> " << file;
    QString filePath = FileController::getUserFilesDir() + file;
    GoogleSpeech * googleSpeech = new GoogleSpeech();
    connect(googleSpeech, &GoogleSpeech::getText, [=](QString text){
        emit this->recognized(file, text.split("\n"));
    });
    SettingsValult * settingsValult = &Singleton<SettingsValult>::Instance();
    googleSpeech->sent(
                filePath
                , settingsValult->getSttLocale()->locale()->name()
                , "AIzaSyBOti4mM-6x9WDnZIjIeyEU21OpBXqWBgw"
                );
}

void SpeechController::synthesize(const QString text)
{
    QString text_to_speech = text;
    if (!text_to_speech.endsWith(".") &&
            !text_to_speech.endsWith("!") &&
            !text_to_speech.endsWith("?"))
        text_to_speech += ".";
    qDebug() << "SpeechController::synthesize >> " << text;
    TTS * tts = &Singleton<TTS>::Instance();
    SettingsValult * settingsValult = &Singleton<SettingsValult>::Instance();
    tts->setVoice(settingsValult->getTtsVoice());
    tts->tell(text_to_speech);
//    tts->say(text_to_speech);
}
