#ifndef GOOGLETRANSLATE_H
#define GOOGLETRANSLATE_H

#include <QObject>
#include <QMap>

#include "utills/singletonwithconfig.h"

class GoogleTranslateConfig;
class QNetworkReply;
class QNetworkAccessManager;

class GoogleTranslate : public QObject
{
    Q_OBJECT
public:
    explicit GoogleTranslate(GoogleTranslateConfig * conf, QObject *parent = 0);
    ~GoogleTranslate();

    void translate(QString text, QString inLang, QString outLang);
    QMap<QString, QString> getAvailableLanguages();

signals:
    void translated(QString text);

public slots:
    void finishedSlot(QNetworkReply*);

private:
    QNetworkAccessManager* nam;
    GoogleTranslateConfig * config;
};

typedef SingletonWithConfig<GoogleTranslate, GoogleTranslateConfig> GoogleTranslateProvider;

#endif // GOOGLETRANSLATE_H
