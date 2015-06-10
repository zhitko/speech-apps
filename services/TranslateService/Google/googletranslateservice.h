#ifndef GOOGLETRANSLATESERVICE_H
#define GOOGLETRANSLATESERVICE_H

#include "../translateservice.h"

#include <QObject>
#include <QMap>

#include "utills/singletonwithconfig.h"

class GoogleTranslateConfig;
class QNetworkReply;
class QNetworkAccessManager;

class GoogleTranslateService : public TranslateService
{
    Q_OBJECT
public:
    explicit GoogleTranslateService(GoogleTranslateConfig * conf, QObject *parent = 0);
    ~GoogleTranslateService();

    void translate(QString text, QString inLang, QString outLang);
    QMap<QString, QString> getAvailableLanguages();

//signals:
//    void translated(QString text);

public slots:
    void finishedSlot(QNetworkReply*);

private:
    QNetworkAccessManager* nam;
    GoogleTranslateConfig * config;
};

typedef SingletonWithConfig<GoogleTranslateService, GoogleTranslateConfig> GoogleTranslateProvider;


#endif // GOOGLETRANSLATESERVICE_H
