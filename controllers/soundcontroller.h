#ifndef SOUNDCONTROLLER_H
#define SOUNDCONTROLLER_H

#include <QObject>

class SoundController : public QObject
{
    Q_OBJECT
public:
    explicit SoundController(QObject *parent = 0);
    ~SoundController();

    Q_INVOKABLE void playFile(const QString);

signals:

public slots:
};

#endif // SOUNDCONTROLLER_H
