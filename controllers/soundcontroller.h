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

    Q_INVOKABLE void startManualRecording();
    Q_INVOKABLE void startAutoRecording();
    Q_INVOKABLE void stopRecording();

signals:
    void recordingFinish(QString);

public slots:

private slots:
    void recordFinished(SoundRecorder*);

private:
    SoundRecorder *recorder;

    QList<QString> wavFileList;
};

#endif // SOUNDCONTROLLER_H
