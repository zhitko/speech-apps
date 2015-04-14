#include "fileobject.h"

FileObject::FileObject(QObject *parent)
    : QObject(parent)
{
}

FileObject::FileObject(const QString &name, const QString &translation, QObject *parent)
    : QObject(parent), mName(name), mTranslation(translation)
{
}

FileObject::~FileObject()
{

}

QString FileObject::name() const
{
    return mName;
}

void FileObject::setName(const QString &name)
{
    if (name != mName) {
        mName = name;
        emit nameChanged();
    }
}

QString FileObject::translation() const
{
    return mTranslation;
}

void FileObject::setTranslation(const QString &translation)
{
    if (translation != mTranslation) {
        mTranslation = translation;
        emit translationChanged();
    }
}
