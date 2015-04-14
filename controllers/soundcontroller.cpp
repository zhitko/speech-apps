#include "soundcontroller.h"

#include "defines.h"

#include "services/sound/soundrecorder.h"
#include "services/sound/soundplayer.h"

#include "system/settingsvalult.h"

#include "utills/singleton.h"

#include "filecontroller.h"

#include "services/sound/soundplayer.h"

#include "models/deviceobject.h"

#include <QDebug>
#include <QDateTime>

SoundController::SoundController(QObject *parent) : QObject(parent),
    recorder(NULL)
{

}

SoundController::~SoundController()
{

}

void SoundController::playFile(const QString fileName)
{
    qDebug() << "SoundController::playFile >> " << fileName;
    QString path = FileController::getUserFilesDir() + fileName;
    SettingsValult * settings = &Singleton<SettingsValult>::Instance();
    oal_device * currentDevice = settings->getCurrentOutputDevice()->device();
    SoundPlayer * player = new SoundPlayer(path, currentDevice);
    player->start();
}

void SoundController::startRecording()
{
    qDebug() << "SoundController::startRecording";

    if(this->recorder == NULL)
    {
        SettingsValult * settings = &Singleton<SettingsValult>::Instance();
        oal_device * currentDevice = settings->getCurrentInputDevice()->device();
        qDebug() << "new SoundRecorder: " << currentDevice->name;
        this->recorder = new SoundRecorder(currentDevice, sizeof(short int), this);
        qDebug() << "is recording: " << this->recorder->isRecording();
        connect(this->recorder, SIGNAL(resultReady(SoundRecorder *)), this, SLOT(recordFinished(SoundRecorder *)));
    }
    this->stopRecording();
    recorder->startRecording();
}

void SoundController::stopRecording()
{
    qDebug() << "SoundController::stopRecording";
    if(recorder->isRecording())
    {
        qDebug() << "SoundController::stopRecording >> stop recording";
        recorder->stopRecording();
    }
}

void SoundController::recordFinished(SoundRecorder * recorder)
{
    qDebug() << "SoundController::recordFinished";

    char *data;
    int size = recorder->getData((void**) &data);
    qDebug() << "SoundController::recordFinished >> result size " << size;

    QDateTime dateTime = QDateTime::currentDateTime();

    QString path = FileController::getUserFilesDir() + dateTime.toString("dd.MM.yyyy hh.mm.ss.zzz") + WAVE_TYPE;
    qDebug() << "SoundController::recordFinished >> write wave to: " << path;

    WaveFile *waveFile = makeWaveFileFromData((char *)data, size, 1, 8000, 16);
    qDebug() << "SoundController::recordFinished >> make wav file";
    saveWaveFile(waveFile, path.toLocal8Bit().data());
    qDebug() << "SoundController::recordFinished >> save wav file";
    waveCloseFile(waveFile);
    qDebug() << "SoundController::recordFinished >> close wav file";
    this->wavFileList.append(path);

    recorder->deleteLater();
    qDebug() << "SoundController::recordFinished >> free recorder";
    this->recorder = NULL;
}
