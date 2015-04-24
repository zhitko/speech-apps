#ifndef DEVICEOBJECT_H
#define DEVICEOBJECT_H

#include <QObject>

#include "utills/OpenAL/openal_wrapper.h"

class DeviceObject : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int index READ index WRITE setIndex NOTIFY indexChanged)

public:
    DeviceObject(QObject *parent = 0);
    DeviceObject(const QString &name, const int &index, oal_device * device, QObject *parent = 0);
    ~DeviceObject();

    QString name() const;
    void setName(const QString &name);

    int index() const;
    void setIndex(const int &index);

    oal_device * device();

signals:
    void nameChanged();
    void indexChanged();

private:
    int mDeviceIndex;
    QString mDeviceName;
    oal_device * mDevice;
};

#endif // DEVICEOBJECT_H
