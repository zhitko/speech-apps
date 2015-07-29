import QtQuick 2.4
import "Utils"

Item {
    property string id: "horoscopeLogic"

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
                "greetings": "Персональный гороскоп - это астрологическая интерпретация влияния Планет на Вашу судьбу"
            },
            "en_US": {
                "computerName": "Computer",
                "userName": "User",
                "recognitionFail": "Not recognized, repeat please",
                "greetings": "Find guidance for this day and every day with your Horoscope"
            }
        }
    }

    /*
      Функция вызывается при старте режима
    */
    function start() {
        var text = messages.get("greetings")
        speechScreen.synthesize(text)
        speechScreen.appendText(messages.get("computerName"), text)
    }

    /*
      Функция вызывается при завершении синтеза речи
    */
    function synthesizeFinish() {
        console.log("ScreenHoroscopeDelegate::synthesizeFinish()")
        speechScreen.startStopAutoRecording()
    }

    /*
      Функция вызывается при завершении детекции отрезка речи
    */
    function recordFinish(file) {
        console.log("ScreenHoroscopeDelegate::recordFinish()")
        speechScreen.recognizeFile(file)
    }

    /*
      Функция вызывается при успешном распознавании речи
    */
    function recognitionFinsh(records) {
        console.log("ScreenHoroscopeDelegate::recognitionFinsh()")
        speechScreen.appendText(messages.get("userName"), records[0])
        speechScreen.synthesize(records[0])
    }

    /*
      Функция вызывается при ошибке распознавания речи
    */
    function recognitionFail(file) {
        console.log("ScreenHoroscopeDelegate::recognitionFail()")
        var text = messages.get("recognitionFail")
        speechScreen.appendText(messages.get("computerName"), text)
        speechScreen.synthesize(text)
    }
}
