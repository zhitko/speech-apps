#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QDebug>
#include <QTranslator>

#include "speechcontroller.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QLocale::setDefault(QLocale::Russian);

    QTranslator translator;
    translator.load(QLocale(), "speech-apps", "_", ":/qml/qml/i18n/", ".qm");
    app.installTranslator(&translator);

    qmlRegisterType<SpeechController>("SpeechApplication", 1,0, "SpeechController");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/qml/main.qml")));

    return app.exec();
}
