#include "translatecontroller.h"

#include "services/TranslateService/translateservice.h"
#include "services/TranslateService/Google/googletranslateconfig.h"
#include "services/TranslateService/Google/googletranslateservice.h"

TranslateController::TranslateController(QObject *parent) : QObject(parent)
{
    translateService = &GoogleTranslateProvider::Instance(&GoogleTranslateConfigProvider::Instance());
}

TranslateController::~TranslateController()
{

}

void TranslateController::translate(QString text, QString from, QString to)
{
    translateService->translate(text, from, to);
}
