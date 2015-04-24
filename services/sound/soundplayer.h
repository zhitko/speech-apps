#ifndef SOUNDPLAYER_H
#define SOUNDPLAYER_H

#include <QThread>

#include "utills/OpenAL/wavFile.h"
#include "utills/OpenAL/openal_wrapper.h"

class QFile;

class SoundPlayer : public QThread
{
    Q_OBJECT
protected:
    void run();
public:
    explicit SoundPlayer(QString path, oal_device * device, QObject *parent = 0);
    ~SoundPlayer();
private:
    QString mPath;
    QFile *file;
    oal_device * mDevice;
    WaveFile * mWaveFile;
signals:

public slots:

};

#endif // SOUNDPLAYER_H
