#ifndef QMLFILE_H
#define QMLFILE_H

#include <QObject>

class QmlFile : public QObject
{
    Q_OBJECT

public:
    Q_PROPERTY(QString source
               READ source
               WRITE setSource
               NOTIFY sourceChanged)
    explicit QmlFile(QObject *parent = 0);

    Q_INVOKABLE QString read();
    Q_INVOKABLE bool write(const QString& data);

    QString source() { return mSource; }

public slots:
    void setSource(const QString& source) { mSource = source; }

signals:
    void sourceChanged(const QString& source);
    void error(const QString& msg);

private:
    QString mSource;
};

#endif // QMLFILE_H
