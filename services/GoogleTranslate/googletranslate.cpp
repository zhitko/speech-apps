#include "googletranslate.h"

#include <QNetworkReply>
#include <QNetworkAccessManager>
#include <QSslConfiguration>

#include "googletranslateconfig.h"

GoogleTranslate::GoogleTranslate(GoogleTranslateConfig * conf, QObject *parent)
    : QObject(parent), config(conf)
{
    nam = new QNetworkAccessManager(this);
    QObject::connect(nam, SIGNAL(finished(QNetworkReply*)), this, SLOT(finishedSlot(QNetworkReply*)));
}

GoogleTranslate::~GoogleTranslate()
{

}

void GoogleTranslate::translate(QString text, QString inLang, QString outLang)
{
    QString url_s = config->getApiUrl().arg(inLang).arg(outLang).arg(text);
    QUrl url(url_s);

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::UserAgentHeader, config->getUserAgent());

    QSslConfiguration config = request.sslConfiguration();
    config.setProtocol(QSsl::TlsV1SslV3);
    request.setSslConfiguration(config);

    nam->get(request);
}

QMap<QString, QString> GoogleTranslate::getAvailableLanguages()
{
    return config->getAvailableLanguages();
}

void GoogleTranslate::finishedSlot(QNetworkReply*)
{

}
