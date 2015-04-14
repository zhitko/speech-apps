#ifndef FILECONTROLLER_H
#define FILECONTROLLER_H

#include <QObject>
#include <QVariant>

#include "models/fileobject.h"

class FileController : public QObject
{
    Q_OBJECT
public:
    explicit FileController(QObject *parent = 0);
    ~FileController();

    Q_INVOKABLE QList<QObject *> getFileList();
    Q_INVOKABLE bool deleteFile(QString);

signals:

public slots:

public:
    static QString getUserFilesDir();
};

#endif // FILECONTROLLER_H
