/*
based on https://gist.github.com/jimmcgowan/4268832
*/

#include <QDebug>

#include "buffer.h"
#include "soundrecorder.h"

SoundRecorder::SoundRecorder(oal_device *device, int sampleByteSize, QObject *parent) :
    QThread(parent), device(device), sampleByteSize(sampleByteSize),
    length(0), allocatedSize(0), avgVolumeLevel(0), recording(false),
    initBuffer(NULL), currentBuffer(NULL)
{
    initAudioInputDevice(this->device);
}

SoundRecorder::~SoundRecorder()
{
    qDebug() << "~SoundRecorder";
    freeAudioInputDevice(this->device);
    freeBuffer(this->initBuffer, true);
}

long int SoundRecorder::getVolumeLevel()
{
    return this->avgVolumeLevel;
}

long int SoundRecorder::getMaxVolumeLevel()
{
    switch(this->sampleByteSize)
    {
        case 1: return CHAR_MAX;
        case 2: return SHRT_MAX;
        case 4: return INT_MAX;
    }
    return 0;
}

bool SoundRecorder::isRecording()
{
    return this->recording;
}

int SoundRecorder::getData(void ** resBuffer)
{
    return getBufferData(this->initBuffer, resBuffer, true);
}

int getValue(void* data, int size)
{
    int res = 0;
    switch(size)
    {
        case 1 :
            res = *((unsigned char*)data);
            break;
        case 2:
            res = *((signed short int *)data);
            break;
        case 4:
            res = *((signed long int *)data);
            break;
    }
    if(res < 0) res *= -1;
    return res;
}

void SoundRecorder::allocateNewBuffer()
{
//    qDebug() << "allocate new buffer";
    if(currentBuffer){
        buffer * current = this->currentBuffer;
        this->currentBuffer = makeBuffer(INIT_BUFFER_SIZE);
        this->currentBuffer->prev = current;
        current->next = this->currentBuffer;
        this->allocatedSize += INIT_BUFFER_SIZE;
    }else{
        this->initBuffer = makeBuffer(INIT_BUFFER_SIZE);
        this->currentBuffer = this->initBuffer;
        this->allocatedSize = INIT_BUFFER_SIZE;
    }
}

void SoundRecorder::run()
{
    this->allocatedSize = 0;
    int currentPos = 0;
    while(recording)
    {
        qDebug() << "recording step " << this->allocatedSize << " ( " << currentPos << " : " << INIT_BUFFER_SIZE << " )";
        if( currentPos >= INIT_BUFFER_SIZE || this->allocatedSize < INIT_BUFFER_SIZE )
        {
            allocateNewBuffer();
            currentPos = 0;
        }
        void * pointToWrite = (char*)this->currentBuffer->buffer_data + currentPos;
        int maxToWrite = INIT_BUFFER_SIZE - currentPos;
        int size = getSample(this->device, pointToWrite, this->sampleByteSize, maxToWrite);
        currentPos += size;

//        int volume = 0;
//        int j = 1;
//        for(j=1; j<100 && j<size; j++,pos+=this->sampleByteSize)
//        {
//            int cVolume = getValue(pos, this->sampleByteSize);
//            if(cVolume > volume) volume = cVolume;
//        }
//        this->avgVolumeLevel = volume;
        msleep(200);
    }
    qDebug() << "stopCapture";
    stopCapture(this->device);
    emit resultReady(this);
}

void SoundRecorder::startRecording()
{
    this->recording = true;
    startCapture(this->device);
    this->start(LowPriority);
}

void SoundRecorder::stopRecording()
{
    this->recording = false;
}
