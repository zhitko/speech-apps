#include "googlespeech.h"

#include <QNetworkAccessManager>
#include <QUrl>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QProcess>
#include <QRegExp>
#include <QDebug>

GoogleSpeech::GoogleSpeech(QObject *parent) :
    QObject(parent)
{
}

void GoogleSpeech::sent(QString file_name)
{
    this->sent(file_name, "ru-ru", "AIzaSyBOti4mM-6x9WDnZIjIeyEU21OpBXqWBgw");
}

void GoogleSpeech::sent(QString file_name, QString lang, QString key)
{
    qDebug() << "GoogleSpeech::sent >> " << file_name << " " << lang << " " << key;

    nam = new QNetworkAccessManager(this);
    QObject::connect(nam, SIGNAL(finished(QNetworkReply*)), this, SLOT(finishedSlot(QNetworkReply*)));

    QString url_s = QString("https://www.google.com/speech-api/v2/recognize?output=json&lang=%1&key=%2").arg(lang).arg(key);
    QUrl url(url_s);

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "audio/l16; rate=16000");
    m_file = new QFile(file_name);
    m_file->open(QFile::ReadOnly);

    QSslConfiguration config = request.sslConfiguration();
    config.setProtocol(QSsl::TlsV1SslV3);
    request.setSslConfiguration(config);

    nam->post(request, m_file);
}

void GoogleSpeech::finishedSlot(QNetworkReply * reply)
{
    m_file->close();
    QVariant statusCodeV = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    QVariant redirectionTargetUrl = reply->attribute(QNetworkRequest::RedirectionTargetAttribute);

    if (reply->error() == QNetworkReply::NoError)
    {
        QByteArray bytes = reply->readAll();
        QString string(bytes);
        qDebug() << "GoogleSpeech::finishedSlot >> " << string;

        QString answer = "";
        QRegExp ans("transcript\":\"(.*)\"");
        ans.setMinimal(true);
        int pos = 0;
        while ((pos = ans.indexIn(string, pos)) != -1) {
            answer = answer + "\n" + ans.cap(1);
            pos += ans.matchedLength();
        }

        emit getText(answer);
        qDebug() << "GoogleSpeech::finishedSlot >> " << answer;
    }
    else
    {
        qDebug() << "GoogleSpeech::finishedSlot >> " << reply->errorString();
    }
}
