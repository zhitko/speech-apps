import QtQuick 2.4
import "Utils"

Item {
    /*
      идентификатор режима работы
      менять не стоит
    */
    property string id: "whiteBullLogic"

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
                "computerName": "Компьютер",
                "userName": "Пользователь",
                "recognitionFail": "Фраза не распознана, пожалуйста повторите.",
                "greetings": "Хочешь? Я Расскажу тебе сказку про белого бычка.",
                "answers": [
                    "Ты %1, я %1. Хочешь? Я Расскажу тебе сказку про белого бычка.",
                    "Ты говоришь: %1, я говорю: %1. Сказать ли тебе сказку про белого бычка?",
                    "Ты говоришь: %1, я: %1. Может тебе сказку про белого бычка рассказать?",
                    "Ты говоришь: %1, а я говорю: %1. Давай я тебе сказку про белого бычка расскажу?"
                ]
            },
            "en_US": {
                "computerName": "Computer",
                "userName": "User",
                "recognitionFail": "Not recognized, repeat please",
                "greetings": "Do you want to listen a story?",
                "answers": [
                    "You say %1, I say %1. Do you want to listen a story?",
                    "Someone say %1, but do you want to listen a story?"
                ]
            }
        }
    }

    /*
      Функция вызывается при старте режима
    */
    function start() {
        var text = messages.get("greetings")
        speechScreen.appendText(messages.get("computerName"), text)
        speechScreen.synthesize(text)
    }

    /*
      Функция вызывается при завершении синтеза речи
    */
    function synthesizeFinish() {
        console.log("ScreenWhiteBullDelegate::synthesizeFinish()")
        speechScreen.startStopAutoRecording()
    }

    /*
      Функция вызывается при завершении детекции отрезка речи
    */
    function recordFinish(file) {
        console.log("ScreenWhiteBullDelegate::recordFinish()")
        speechScreen.recognizeFile(file)
    }

    /*
      Функция вызывается при успешном распознавании речи
    */
    function recognitionFinsh(records) {
        console.log("ScreenWhiteBullDelegate::recognitionFinsh()")
        speechScreen.appendText(messages.get("userName"), records[0])
        var text = messages.getRandom("answers").arg(records[0])
        console.log(text)
        speechScreen.appendText(messages.get("computerName"), text)
        speechScreen.synthesize(text)
    }

    /*
      Функция вызывается при ошибке распознавания речи
    */
    function recognitionFail(file) {
        console.log("ScreenWhiteBullDelegate::recognitionFail()")
        var text = messages.get("recognitionFail")
        speechScreen.appendText(messages.get("computerName"), text)
        speechScreen.synthesize(text)
    }
}
