#include "files.h"

#include <QStringList>
#include <QDir>
#include <QDirIterator>

QStringList scanDirIter(const QDir dir, const QString extension)
{
    QStringList files;
    QString path = dir.absolutePath();
    QDirIterator iterator(path, QDirIterator::Subdirectories);
    while (iterator.hasNext()) {
        iterator.next();
        if (!iterator.fileInfo().isDir()) {
            QString filename = iterator.filePath();
            if (filename.endsWith(extension))
                files.append(filename.remove(path));
        }
    }
    return files;
}
