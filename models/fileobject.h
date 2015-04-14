#ifndef FILEOBJECT_H
#define FILEOBJECT_H

#include <QObject>

class FileObject : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString translation READ translation WRITE setTranslation NOTIFY translationChanged)
public:
    FileObject(QObject *parent = 0);
    FileObject(const QString &name, const QString &translation, QObject *parent=0);
    ~FileObject();

    QString name() const;
    void setName(const QString &name);

    QString translation() const;
    void setTranslation(const QString &translation);

signals:
    void nameChanged();
    void translationChanged();

private:
    QString mName;
    QString mTranslation;
};

#endif // FILEOBJECT_H
