#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlContext>
#include <QDebug>
#include <QTranslator>

#include "controllers/speechcontroller.h"
#include "controllers/filecontroller.h"
#include "controllers/soundcontroller.h"
#include "controllers/settingscontroller.h"

#include "system/settingsvalult.h"

#include "models/localeobject.h"

#include "utills/singleton.h"

#include "services/tts/tts.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    SettingsController settingsController;
    FileController fileController;
    SoundController soundController;
    SpeechController speechController;

    SettingsValult * settings = &Singleton<SettingsValult>::Instance();

    LocaleObject * uiLocale = settings->getUiLocale();
    if (uiLocale != NULL)
    {
        QLocale::setDefault(*uiLocale->locale());
    }

    QTranslator translator;
    translator.load(QLocale(), "speech-apps", "_", ":/qml/qml/i18n/", ".qm");
    app.installTranslator(&translator);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/qml/main.qml")));

    engine.rootContext()->setContextProperty("settingsController", &settingsController);
    engine.rootContext()->setContextProperty("fileController", &fileController);
    engine.rootContext()->setContextProperty("soundController", &soundController);
    engine.rootContext()->setContextProperty("speechController", &speechController);

    return app.exec();
}
