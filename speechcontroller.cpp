#include "speechcontroller.h"
#include <QDebug>
#include <QDateTime>
#include <QApplication>

#include "sound/soundrecorder.h"

SpeechController::SpeechController(QObject *parent) : QObject(parent),
    recorder(NULL)
{
    qDebug() << "SpeechController::SpeechController";
}

SpeechController::~SpeechController()
{
    qDebug() << "SpeechController::~SpeechController";
}

void SpeechController::startRecording()
{
    qDebug() << "SpeechController::startRecording";

    if(this->recorder == NULL)
    {

        oal_devices_list *outputDevices = getInputDevices();
        if(outputDevices) {
//            oal_device * currentDevice = this->settingsDialog->getInputDevice();
            oal_device * currentDevice = outputDevices->device;
            qDebug() << "new SoundRecorder: " << currentDevice->name;
            this->recorder = new SoundRecorder(currentDevice, sizeof(short int), this);
            qDebug() << "is recording: " << this->recorder->isRecording();
            connect(this->recorder, SIGNAL(resultReady(SoundRecorder *)), this, SLOT(recordFinished(SoundRecorder *)));
        }
    }
    this->stopRecording();
    recorder->startRecording();
}

void SpeechController::stopRecording()
{
    qDebug() << "SpeechController::stopRecording";
    if(recorder->isRecording())
    {
        qDebug() << "SpeechController::stopRecording >> stop recording";
        recorder->stopRecording();
    }
}

void SpeechController::recordFinished(SoundRecorder * recorder)
{
    qDebug() << "SpeechController::recordFinished";

    char *data;
    int size = recorder->getData((void**) &data);
    qDebug() << "SpeechController::recordFinished >> result size " << size;

    QDateTime dateTime = QDateTime::currentDateTime();
    QString path = USER_DATA_PATH + dateTime.toString("dd.MM.yyyy hh.mm.ss.zzz");

    path = QApplication::applicationDirPath() + DATA_PATH + path + WAVE_TYPE;
    qDebug() << "SpeechController::recordFinished >> write wave to: " << path;

    WaveFile *waveFile = makeWaveFileFromData((char *)data, size, 1, 8000, 16);
    qDebug() << "SpeechController::recordFinished >> make wav file";
    saveWaveFile(waveFile, path.toLocal8Bit().data());
    qDebug() << "SpeechController::recordFinished >> save wav file";
    waveCloseFile(waveFile);
    qDebug() << "SpeechController::recordFinished >> close wav file";

    recorder->deleteLater();
    qDebug() << "SpeechController::recordFinished >> free recorder";
    this->recorder = NULL;
}
