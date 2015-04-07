#ifndef SPEECHCONTROLLER_H
#define SPEECHCONTROLLER_H

#include <QObject>

extern "C" {
    #include "./OpenAL/openal_wrapper.h"
    #include "./OpenAL/wavFile.h"
}

#define DATA_PATH "/data"
#define USER_DATA_PATH "/RECORDS/"
#define WAVE_TYPE ".wav"

class SoundRecorder;

class SpeechController : public QObject
{
    Q_OBJECT
public:
    explicit SpeechController(QObject *parent = 0);
    ~SpeechController();

    Q_INVOKABLE void startRecording();
    Q_INVOKABLE void stopRecording();
signals:

public slots:

private slots:
    void recordFinished(SoundRecorder*);

private:
    SoundRecorder *recorder;
};

#endif // SPEECHCONTROLLER_H