#ifndef SETTINGSVALULT_H
#define SETTINGSVALULT_H

#include <QObject>
#include <QLocale>

class DeviceObject;
class LocaleObject;

class SettingsValult : public QObject
{
    Q_OBJECT
public:
    explicit SettingsValult(QObject *parent = 0);
    ~SettingsValult();

    DeviceObject * getCurrentOutputDevice();
    DeviceObject * getCurrentInputDevice();

    LocaleObject * getUiLocale() const;
    void setUiLocale(LocaleObject *);

    LocaleObject * getSttLocale() const;
    void setSttLocale(LocaleObject *);

    QString getTtsVoice() const;
    void setTtsVoice(QString);

signals:
    void uiLocaleChanged();
    void sttLocaleChanged();
    void ttsVoiceChanged();

public slots:

public:
    QList<DeviceObject *> mOutputDevices;
    DeviceObject * mCurrentOutputDevice;
    QList<DeviceObject *> mInputDevices;
    DeviceObject * mCurrentInputDevice;

private:
    LocaleObject * mUiLocale;
    LocaleObject * mSttLocale;
    QString mTtsVoice;
};

#endif // SETTINGSVALULT_H
