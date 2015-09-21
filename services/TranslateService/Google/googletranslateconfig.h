#ifndef GOOGLETRANSLATECONFIG
#define GOOGLETRANSLATECONFIG

#include <QObject>
#include <QMap>

#include "utills/singleton.h"

class GoogleTranslateConfig
{
public:
    GoogleTranslateConfig() {}
    ~GoogleTranslateConfig() {}

    virtual QString getDefaultInputLanguage() {
        return "auto";
    }

    virtual QString getDefaultOutputLanguage() {
        return "en";
    }

    virtual QString getUserAgent() {
        return "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome Safari/537.36";
    }

    virtual QString getApiUrl() {
        return "https://translate.google.com/translate_a/single?client=t&sl=%1&tl=%2&dt=t&q=%3";
    }

    virtual QMap<QString, QString> getAvailableLanguages() {
        QMap<QString, QString> languages;
        languages.insert("Auto Detect", "auto");
        languages.insert("Afrikaans", "af");
        languages.insert("Irish", "ga");
        languages.insert("Albanian", "sq");
        languages.insert("Italian", "it");
        languages.insert("Arabic", "ar");
        languages.insert("Japanese", "ja");
        languages.insert("Azerbaijani", "az");
        languages.insert("Kannada", "kn");
        languages.insert("Basque", "eu");
        languages.insert("Korean", "ko");
        languages.insert("Bengali", "bn");
        languages.insert("Latin", "la");
        languages.insert("Belarusian", "be");
        languages.insert("Latvian", "lv");
        languages.insert("Bulgarian", "bg");
        languages.insert("Lithuanian", "lt");
        languages.insert("Catalan", "ca");
        languages.insert("Macedonian", "mk");
        languages.insert("Chinese Simplified", "zh-CN");
        languages.insert("Malay", "ms");
        languages.insert("Chinese Traditional", "zh-TW");
        languages.insert("Maltese", "mt");
        languages.insert("Croatian", "hr");
        languages.insert("Norwegian", "no");
        languages.insert("Czech", "cs");
        languages.insert("Persian", "fa");
        languages.insert("Danish", "da");
        languages.insert("Polish", "pl");
        languages.insert("Dutch", "nl");
        languages.insert("Portuguese", "pt");
        languages.insert("English", "en");
        languages.insert("Romanian", "ro");
        languages.insert("Esperanto", "eo");
        languages.insert("Russian", "ru");
        languages.insert("Estonian", "et");
        languages.insert("Serbian", "sr");
        languages.insert("Filipino", "tl");
        languages.insert("Slovak", "sk");
        languages.insert("Finnish", "fi");
        languages.insert("Slovenian", "sl");
        languages.insert("French", "fr");
        languages.insert("Spanish", "es");
        languages.insert("Galician", "gl");
        languages.insert("Swahili", "sw");
        languages.insert("Georgian", "ka");
        languages.insert("Swedish", "sv");
        languages.insert("German", "de");
        languages.insert("Tamil", "ta");
        languages.insert("Greek", "el");
        languages.insert("Telugu", "te");
        languages.insert("Gujarati", "gu");
        languages.insert("Thai", "th");
        languages.insert("Haitian Creole", "ht");
        languages.insert("Turkish", "tr");
        languages.insert("Hebrew", "iw");
        languages.insert("Ukrainian", "uk");
        languages.insert("Hindi", "hi");
        languages.insert("Urdu", "ur");
        languages.insert("Hungarian", "hu");
        languages.insert("Vietnamese", "vi");
        languages.insert("Icelandic", "is");
        languages.insert("Welsh", "cy");
        languages.insert("Indonesian", "id");
        languages.insert("Yiddish", "yi");
        return languages;
    }
};

typedef Singleton<GoogleTranslateConfig> GoogleTranslateConfigProvider;

#endif // GOOGLETRANSLATECONFIG

