#include "soundplayer.h"

#include <QDebug>
#include <QTextCodec>
#include <QFile>

SoundPlayer::SoundPlayer(QString path, oal_device * device, QObject *parent) :
    QThread(parent), mPath(path), mDevice(device), mWaveFile(0)
{
    qDebug() << "SoundPlayer: init";
    initAudioOutputDevice(this->mDevice);
    if(!this->mDevice->device){
        qDebug() << "SoundPlayer: FAIL init output device "
                 << QString::fromLocal8Bit(this->mDevice->name);
        return;
    }
    qDebug() << "SoundPlayer: open wav file " << mPath;

    this->file = new QFile(mPath);
    file->open(QIODevice::ReadOnly);
    this->mWaveFile = waveOpenHFile(file->handle());
}

SoundPlayer::~SoundPlayer()
{
    qDebug() << "~SoundPlayer";
    freeAudioOutputDevice(this->mDevice);
    if(this->file->isOpen()) this->file->close();
    waveCloseFile(mWaveFile);
}

void SoundPlayer::run()
{
    qDebug() << "SoundPlayer: run";
    playSound(
                this->mDevice,
                this->mWaveFile->dataChunk->waveformData,
                littleEndianBytesToUInt32(this->mWaveFile->dataChunk->chunkDataSize),
                littleEndianBytesToUInt16(this->mWaveFile->formatChunk->numberOfChannels),
                littleEndianBytesToUInt16(this->mWaveFile->formatChunk->significantBitsPerSample),
                littleEndianBytesToUInt32(this->mWaveFile->formatChunk->sampleRate));
    this->deleteLater();
}
