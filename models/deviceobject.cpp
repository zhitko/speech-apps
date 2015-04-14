#include "deviceobject.h"

DeviceObject::DeviceObject(QObject *parent) : QObject(parent)
{

}

DeviceObject::DeviceObject(const QString &name, const int &index, oal_device * device, QObject *parent)
    : QObject(parent), mDeviceName(name), mDeviceIndex(index), mDevice(device)
{

}

DeviceObject::~DeviceObject()
{

}

QString DeviceObject::name() const
{
    return this->mDeviceName;
}

void DeviceObject::setName(const QString &name)
{
    if (this->mDeviceName != name)
    {
        this->mDeviceName = name;
        emit nameChanged();
    }
}

int DeviceObject::index() const
{
    return this->mDeviceIndex;
}

void DeviceObject::setIndex(const int &index)
{
    if (this->mDeviceIndex != index)
    {
        this->mDeviceIndex = index;
        emit indexChanged();
    }
}

oal_device * DeviceObject::device()
{
    return this->mDevice;
}
