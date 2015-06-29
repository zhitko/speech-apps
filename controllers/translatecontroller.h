#ifndef TRANSLATECONTROLLER_H
#define TRANSLATECONTROLLER_H

#include <QObject>

class TranslateService;

class TranslateController : public QObject
{
    Q_OBJECT
public:
    explicit TranslateController(QObject *parent = 0);
    ~TranslateController();

    Q_INVOKABLE void translate(QString text, QString from, QString to);
    Q_INVOKABLE QList<QObject *> getLanguageList();

signals:
    void translated(QString);

public slots:

private:
    TranslateService * translateService;
};

#endif // TRANSLATECONTROLLER_H
