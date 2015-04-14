#include "localeobject.h"

#include <QLocale>

LocaleObject::LocaleObject(QObject *parent) : QObject(parent)
{

}

LocaleObject::LocaleObject(QLocale * locale, QObject *parent)
    : QObject(parent)
    , mLocale(locale)
{

}

LocaleObject::LocaleObject(QLocale locale, QObject *parent)
    : QObject(parent)
    , mLocale(new QLocale(locale))
{

}

LocaleObject::~LocaleObject()
{

}

QString LocaleObject::code() const
{
    return this->locale()->name();
}

QString LocaleObject::name() const
{
    return this->locale()->nativeLanguageName();
}

QLocale * LocaleObject::locale() const
{
    return this->mLocale;
}

void LocaleObject::setLocale(QLocale *locale)
{
    if(this->mLocale != locale)
    {
        this->mLocale = locale;
        emit localeChanged();
    }
}

void LocaleObject::setLocale(QLocale locale)
{
    this->mLocale = new QLocale(locale);
    emit localeChanged();
}
