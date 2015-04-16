#ifndef TTS_H
#define TTS_H

#include <QObject>

class QtSpeech;

class TTS : public QObject
{
    Q_OBJECT
public:
    explicit TTS(QObject *parent = 0);
    ~TTS();

    void say(QString);
    void tell(QString);

private:
    QtSpeech * speech;
    
signals:
    void finished();
    
public slots:
    void _finished();
    
};

#endif // TTS_H
