#include "settingsvalult.h"

#include "models/deviceobject.h"

SettingsValult::SettingsValult(QObject *parent)
    : QObject(parent)
    , mUiLocale(0)
    , mSttLocale(0)
    , mTtsVoice("")
    , mCurrentOutputDevice(0)
    , mCurrentInputDevice(0)
{

}

SettingsValult::~SettingsValult()
{

}

DeviceObject * SettingsValult::getCurrentOutputDevice()
{
    return this->mCurrentOutputDevice;
}

DeviceObject * SettingsValult::getCurrentInputDevice()
{
    return this->mCurrentInputDevice;
}

LocaleObject * SettingsValult::getUiLocale() const
{
    return this->mUiLocale;
}

void SettingsValult::setUiLocale(LocaleObject * locale)
{
    if (locale != this->mUiLocale)
    {
        this->mUiLocale = locale;
        emit uiLocaleChanged();
    }
}

LocaleObject * SettingsValult::getSttLocale() const
{
    return this->mSttLocale;
}

void SettingsValult::setSttLocale(LocaleObject * locale)
{
    if (locale != this->mSttLocale)
    {
        this->mSttLocale = locale;
        emit sttLocaleChanged();
    }
}

QString SettingsValult::getTtsVoice() const
{
    return this->mTtsVoice;
}

void SettingsValult::setTtsVoice(QString voice)
{
    if (voice != this->mTtsVoice)
    {
        this->mTtsVoice = voice;
        emit ttsVoiceChanged();
    }
}
