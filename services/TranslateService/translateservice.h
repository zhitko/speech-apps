#ifndef TRANSLATESERVICE
#define TRANSLATESERVICE

#include <QObject>
#include <QMap>

class TranslateService : public QObject
{
    Q_OBJECT
public:
    explicit TranslateService(QObject *parent = 0): QObject(parent) {}
    virtual ~TranslateService() {}

    virtual void translate(QString text, QString fromLang, QString toLang) = 0;
    virtual QMap<QString, QString> getAvailableLanguages() = 0;

signals:
    void translated(QString text);
};

#endif // TRANSLATESERVICE

