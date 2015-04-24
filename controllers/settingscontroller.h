#ifndef SETTINGSCONTROLLER_H
#define SETTINGSCONTROLLER_H

#include <QObject>
#include <QHash>
#include <QStringList>

#include "defines.h"

class SettingsValult;
class LocaleObject;

class SettingsController : public QObject
{
    Q_OBJECT
public:
    explicit SettingsController(QObject *parent = 0);
    ~SettingsController();

    Q_INVOKABLE QList<QObject *> getInputDeviceList();
    Q_INVOKABLE void setInputDevice(const int);
    Q_INVOKABLE int getInputDevice() const;

    Q_INVOKABLE QList<QObject *> getOutputDeviceList();
    Q_INVOKABLE void setOutputDevice(const int);
    Q_INVOKABLE int getOutputDevice() const;

    Q_INVOKABLE QList<QObject *> getUiLanguageList();
    Q_INVOKABLE void setUiLanguage(const QString);
    Q_INVOKABLE int getUiLanguage() const;

    Q_INVOKABLE QList<QObject *> getSttLanguageList();
    Q_INVOKABLE void setSttLanguage(const QString);
    Q_INVOKABLE int getSttLanguage() const;

    Q_INVOKABLE QStringList getTtsVoiceList();
    Q_INVOKABLE void setTtsVoice(const QString);
    Q_INVOKABLE int getTtsVoice() const;

    Q_INVOKABLE void loadSettings();
    Q_INVOKABLE void saveSettings();

signals:

public slots:

private:
    void initAudio();

    SettingsValult * settingsValult;

    QList<LocaleObject *> availableUiLanguages;
    QList<LocaleObject *> availableSttLanguages;
    QList<QString> availableTtsVoice;
    QHash<QString, LocaleObject *> availableLanguages;
};

#endif // SETTINGSCONTROLLER_H
