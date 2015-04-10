#ifndef SPEECHCONTROLLER_H
#define SPEECHCONTROLLER_H

#include <QObject>

extern "C" {
    #include "utills/OpenAL/openal_wrapper.h"
    #include "utills/OpenAL/wavFile.h"
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

    Q_INVOKABLE void playLast();
    Q_INVOKABLE void recognizeLast();
signals:

public slots:

private slots:
    void recordFinished(SoundRecorder*);

private:
    SoundRecorder *recorder;

    QList<QString> wavFileList;
};

#endif // SPEECHCONTROLLER_H
