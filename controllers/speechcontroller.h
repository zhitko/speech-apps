#ifndef SPEECHCONTROLLER_H
#define SPEECHCONTROLLER_H

#include <QObject>

class SpeechController : public QObject
{
    Q_OBJECT
public:
    explicit SpeechController(QObject *parent = 0);
    ~SpeechController();

    Q_INVOKABLE void recognizeFile(QString);

    Q_INVOKABLE void synthesize(QString);

signals:
    void finishSpeaking();
    void recognized(QString, QList<QString>);

public slots:

};

#endif // SPEECHCONTROLLER_H
