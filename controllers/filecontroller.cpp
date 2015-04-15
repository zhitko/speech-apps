#include "filecontroller.h"

#include "defines.h"

#include <QDebug>

#include <QDir>
#include <QFile>
#include <QStringList>
#include <QApplication>
#include <QTextStream>

#include "utills/files.h"

#include "models/fileobject.h"

FileController::FileController(QObject *parent) : QObject(parent)
{

}

FileController::~FileController()
{

}

QString FileController::getUserFilesDir()
{
    return QApplication::applicationDirPath() + DATA_PATH + USER_DATA_PATH;
}

QList<QObject *> FileController::getFileList()
{
    qDebug() << "FileController::getFileList";
    QString directory = getUserFilesDir();
    QStringList fileList = scanDirIter(QDir(directory), WAVE_TYPE);
    fileList.sort();

    QList<QObject *> fileModelsList;
    for(QString fileName: fileList)
    {
        QString translation;
        QString translateFileName = directory + fileName.remove(0,1) + TRANSL_TYPE;
        QFile translateFile(translateFileName);
        if (translateFile.open(QIODevice::ReadOnly | QIODevice::Text))
        {
            while (!translateFile.atEnd()) {
                QByteArray data = translateFile.readAll();
                translation = QString(data);
            }
        }
        fileModelsList.append(new FileObject(fileName, translation));
    }
    return fileModelsList;
}

bool FileController::deleteFile(const QString fileName)
{
    qDebug() << "FileController::deleteFile >> " << fileName;
    QString path = getUserFilesDir() + fileName;
    return QFile(path).remove();
}

void FileController::setFileTranslation(const QString fileName, const QString translation)
{
    qDebug() << "FileController::setFileTranslation >> " << fileName << " : " << translation;
    QString path = getUserFilesDir() + fileName + TRANSL_TYPE;
    QFile descriptionFile(path);
    if (descriptionFile.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QTextStream out(&descriptionFile);
        out << translation;
        descriptionFile.close();
    }
}
