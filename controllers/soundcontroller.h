#ifndef SOUNDCONTROLLER_H
#define SOUNDCONTROLLER_H

#include <QObject>

extern "C" {
    #include "utills/OpenAL/openal_wrapper.h"
    #include "utills/OpenAL/wavFile.h"
}

class SoundRecorder;

class SoundController : public QObject
{
    Q_OBJECT
public:
    explicit SoundController(QObject *parent = 0);
    ~SoundController();

    Q_INVOKABLE void playFile(const QString);

    Q_INVOKABLE void startRecording();
    Q_INVOKABLE void stopRecording();

signals:

public slots:

private slots:
    void recordFinished(SoundRecorder*);

private:
    SoundRecorder *recorder;

    QList<QString> wavFileList;
};

#endif // SOUNDCONTROLLER_H
