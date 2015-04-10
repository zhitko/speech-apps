#ifndef FILECONTROLLER_H
#define FILECONTROLLER_H

#include <QObject>
#include <QStringList>

class FileController : public QObject
{
    Q_OBJECT
public:
    explicit FileController(QObject *parent = 0);
    ~FileController();

    Q_INVOKABLE QStringList getFileList();
    Q_INVOKABLE bool deleteFile(QString);

signals:

public slots:

public:
    static QString getUserFilesDir();
};

#endif // FILECONTROLLER_H
