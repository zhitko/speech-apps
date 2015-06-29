import QtQuick 2.4
import "Utils"

Item {
    property string id: "translateLogic"

    /*
      Объект предоставляющий функционал управления диалогом
      Функции:
      function appendText(actor, text)
        Добавить текст <text> на экран

      function recognizeFile(file)
        Отправить файл на распознавание, при успешном исходе будет
        вызван метод recognitionFinsh, при ошибке распознавания
        будет вызван метод recognitionFail

      function startStopManualRecording ()
        Запустить (или остановить если идет запись) ручного режима
        записи речи

      function startStopAutoRecording ()
        Запустить (или остановить если идет запись) автоматического
        режима записи речи

      function synthesize (text)
        Синтез текста
    */
    property Item speechScreen

    /*
      Перечень доступных языков
    */
    Messages {
        id: messages
        messages: {
            "ru_RU": {
                "translated": "Перевод",
                "computerName": "Компьютер",
                "userName": "Пользователь",
                "recognitionFail": "Фраза не распознана, пожалуйста повторите.",
                "greetings": "Привет! Начнем работу?"
            },
            "en_US": {
                "translated": "Translation",
                "computerName": "Computer",
                "userName": "User",
                "recognitionFail": "Not recognized, repeat please",
                "greetings": "Hello! let's start work!"
            }
        }
    }

    /*
      Функция вызывается при старте режима
    */
    function start() {
        var text = messages.get("greetings", speechScreen.destinationLanguage)
        speechScreen.synthesize(text)
        speechScreen.appendText(messages.get("computerName"), text)
    }

    /*
      Функция вызывается при завершении синтеза речи
    */
    function synthesizeFinish() {
        console.log("ScreenParrotDelegate::synthesizeFinish()")
        speechScreen.startStopAutoRecording()
    }

    /*
      Функция вызывается при завершении детекции отрезка речи
    */
    function recordFinish(file) {
        console.log("ScreenParrotDelegate::recordFinish()")
        speechScreen.recognizeFile(file)
    }

    /*
      Функция вызывается при успешном распознавании речи
    */
    function recognitionFinsh(records) {
        console.log("ScreenParrotDelegate::recognitionFinsh()")
        speechScreen.appendText(messages.get("userName"), records[0])
        speechScreen.translate(records[0], speechScreen.sourceLanguage, speechScreen.destinationLanguage);
    }

    /*
      Функция вызывается при ошибке распознавания речи
    */
    function recognitionFail(file) {
        console.log("ScreenParrotDelegate::recognitionFail()")
        var text = messages.get("recognitionFail", speechScreen.destinationLanguage)
        speechScreen.appendText(messages.get("computerName"), text)
        speechScreen.synthesize(text)
    }

    function translated(result) {
        console.log("ScreenTranslateDelegate::translated " + result)
        speechScreen.appendText(messages.get("translated"), result)
        speechScreen.synthesize(result)
    }
}
