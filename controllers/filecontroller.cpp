#include "filecontroller.h"

#include "defines.h"

#include <QDebug>

#include <QDir>
#include <QStringList>
#include <QApplication>

#include "utills/files.h"

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

QStringList FileController::getFileList()
{
    qDebug() << "FileController::getFileList";
    QDir directory(getUserFilesDir());
    QStringList fileList = scanDirIter(directory, WAVE_TYPE);
    fileList.sort();
    return fileList;
}

bool FileController::deleteFile(QString fileName)
{
    qDebug() << "FileController::deleteFile >> " << fileName;
    QString path = getUserFilesDir() + fileName;
    return QFile(path).remove();
}
