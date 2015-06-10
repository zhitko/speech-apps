#include "googletranslateservice.h"

#include <QNetworkReply>
#include <QNetworkAccessManager>
#include <QSslConfiguration>
#include <QUrlQuery>

#include "googletranslateconfig.h"

GoogleTranslateService::GoogleTranslateService(GoogleTranslateConfig * conf, QObject *parent)
    : TranslateService(parent), config(conf)
{
    nam = new QNetworkAccessManager(this);
    QObject::connect(nam, SIGNAL(finished(QNetworkReply*)), this, SLOT(finishedSlot(QNetworkReply*)));
}

GoogleTranslateService::~GoogleTranslateService()
{

}

void GoogleTranslateService::translate(QString text, QString inLang, QString outLang)
{
    QString url_s = config->getApiUrl().arg(inLang).arg(outLang);
    QUrl url(url_s);

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::UserAgentHeader, config->getUserAgent());

    QSslConfiguration config = request.sslConfiguration();
    config.setProtocol(QSsl::TlsV1SslV3);
    request.setSslConfiguration(config);

    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");
    QUrlQuery query;
    query.addQueryItem("text", text);
    QByteArray data;
    data.append(query.query());

    nam->post(request, data);
}

QMap<QString, QString> GoogleTranslateService::getAvailableLanguages()
{
    return config->getAvailableLanguages();
}

void GoogleTranslateService::finishedSlot(QNetworkReply* reply)
{
    if (reply->error() == QNetworkReply::NoError)
    {
        QByteArray bytes = reply->readAll();
        QString string = QString::fromUtf8(bytes);
        qDebug() << "GoogleTranslateService::finishedSlot >> " << string;

//        QString answer = "";
//        QRegExp ans("transcript\":\"(.*)\"");
//        ans.setMinimal(true);
//        int pos = 0;
//        while ((pos = ans.indexIn(string, pos)) != -1) {
//            answer = answer + "\n" + ans.cap(1);
//            pos += ans.matchedLength();
//        }

//        emit getText(answer.trimmed());
//        qDebug() << "GoogleTranslate::finishedSlot >> " << answer.trimmed();
    }
    else
    {
        qDebug() << "GoogleTranslateService::finishedSlot >> " << reply->errorString();
    }
}
