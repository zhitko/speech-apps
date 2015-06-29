#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlContext>
#include <QQmlProperty>
#include <QDebug>
#include <QTranslator>
#include <QDir>

#include "controllers/speechcontroller.h"
#include "controllers/filecontroller.h"
#include "controllers/soundcontroller.h"
#include "controllers/settingscontroller.h"
#include "controllers/translatecontroller.h"

#include "system/settingsvalult.h"

#include "models/localeobject.h"

#include "utills/singleton.h"
#include "utills/files.h"

#include "services/tts/tts.h"

void loadExternalJs(QQmlApplicationEngine * engine);

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    SettingsValult * settings = &Singleton<SettingsValult>::Instance();

    SettingsController settingsController;
    FileController fileController;
    SoundController soundController;
    SpeechController speechController;
    TranslateController translateController;

    LocaleObject * uiLocale = settings->getUiLocale();
    if (uiLocale != NULL)
    {
        QLocale::setDefault(*uiLocale->locale());
    }

    QTranslator translator;
    translator.load(QLocale(), "speech-apps", "_", ":/qml/i18n/", ".qm");
    app.installTranslator(&translator);

    QQmlApplicationEngine engine;
    loadExternalJs(&engine);
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    engine.rootContext()->setContextProperty("settingsController", &settingsController);
    engine.rootContext()->setContextProperty("fileController", &fileController);
    engine.rootContext()->setContextProperty("soundController", &soundController);
    engine.rootContext()->setContextProperty("speechController", &speechController);
    engine.rootContext()->setContextProperty("translateController", &translateController);


    return app.exec();
}

void loadExternalJs(QQmlApplicationEngine * engine)
{
    QDir logicDir = QDir(QApplication::applicationDirPath());
    logicDir.cd("logic");
    QStringList externalFiles = scanDirIter(logicDir, "qml");
    foreach (QString externalFile, externalFiles) {
        QString filePath = logicDir.absolutePath() + externalFile;
        qDebug() << "try load " << filePath;
        QQmlComponent component(engine, QUrl::fromLocalFile(filePath));
        qDebug() << "component " << component.errorString();
        QObject *object = component.create(engine->rootContext());
        engine->rootContext()->setContextProperty(object->property("id").toString(), object);
        QQmlEngine::setObjectOwnership(object, QQmlEngine::CppOwnership);
    }
}
