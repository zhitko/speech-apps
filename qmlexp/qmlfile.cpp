#include "qmlfile.h"
#include <QFile>
#include <QFileInfo>
#include <QTextStream>

#include <QDebug>

QmlFile::QmlFile(QObject *parent) :
    QObject(parent)
{

}

QString QmlFile::read()
{
    if (mSource.isEmpty()){
        emit error("source is empty");
        return QString();
    }

    QFile file(mSource);
    QFileInfo fileInfo(file);
    qDebug() << fileInfo.absoluteFilePath();
    QString fileContent;
    if ( file.open(QIODevice::ReadOnly) ) {
        QString line;
        QTextStream t( &file );
        do {
            line = t.readLine();
            fileContent += line;
         } while (!line.isNull());

        file.close();
    } else {
        emit error("Unable to open the file");
        return QString();
    }
    return fileContent;
}

bool QmlFile::write(const QString& data)
{
    if (mSource.isEmpty())
        return false;

    QFile file(mSource);
    if (!file.open(QFile::WriteOnly | QFile::Truncate))
        return false;

    QTextStream out(&file);
    out << data;

    file.close();

    return true;
}
