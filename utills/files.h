#ifndef FILES_H
#define FILES_H

class QDir;
class QString;
class QStringList;

QStringList scanDirIter(const QDir dir, const QString extension);

#endif // FILES_H
