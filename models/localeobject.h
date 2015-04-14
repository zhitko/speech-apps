#ifndef LOCALEOBJECT_H
#define LOCALEOBJECT_H

#include <QObject>

class QLocale;

class LocaleObject : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QString code READ code)
public:
    LocaleObject(QObject *parent = 0);
    LocaleObject(QLocale * locale, QObject *parent = 0);
    LocaleObject(QLocale locale, QObject *parent = 0);
    ~LocaleObject();

    QString name() const;
    QString code() const;

    QLocale * locale() const;
    void setLocale(QLocale * locale);
    void setLocale(QLocale locale);

signals:
    void nameChanged();
    void localeChanged();

public slots:

private:
    QLocale * mLocale;
};

#endif // LOCALEOBJECT_H
