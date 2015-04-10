#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QDebug>
#include <QTranslator>

#include "controllers/speechcontroller.h"
#include "controllers/filecontroller.h"
#include "controllers/soundcontroller.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QLocale::setDefault(QLocale::Russian);

    QTranslator translator;
    translator.load(QLocale(), "speech-apps", "_", ":/qml/qml/i18n/", ".qm");
    app.installTranslator(&translator);

    qmlRegisterType<SpeechController>("SpeechApplication", 1,0, "SpeechController");
    qmlRegisterType<FileController>("SpeechApplication", 1,0, "FileController");
    qmlRegisterType<SoundController>("SpeechApplication", 1,0, "SoundController");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/qml/main.qml")));

    return app.exec();
}
