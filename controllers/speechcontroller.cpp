#include "speechcontroller.h"
#include <QDebug>

#include "defines.h"

#include "filecontroller.h"

#include "services/Google/googlespeech.h"

SpeechController::SpeechController(QObject *parent) : QObject(parent)
{
    qDebug() << "SpeechController::SpeechController";
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
        emit this->recognized(text.split("\n"));
    });
    googleSpeech->sent(filePath);
}
