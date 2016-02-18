import QtQuick 2.4
import "Utils"

Item {
    property string id: "ticketLogic"

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
    property Item mainSpeechControl

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
                "greetings": "Здравствуйте! Какой билет вам нужен?"
            },
            "en_US": {
                "computerName": "Computer",
                "userName": "User",
                "recognitionFail": "Not recognized, repeat please",
                "greetings": "Hello! Make request and make answer following questions."
            }
        }
    }

    property var enums: {
        "type": ["train", "plane", "bus"]
    }

    property var dictionary: {
        "type": {
            "train": ["поезд"],
            "plane": ["самолет"],
            "bus": ["автобус"]
        }
    }

    property var urls: {
        "train": "http://rasp.rw.by/ru/route/?from={}&to={}&date={}&from_esr=&from_exp=&to_esr=&to_exp="
    }

    property var context: {
        "source": "",
        "destination": "",
        "source_time": "",
        "source_day": "",
        "destination_time": "",
        "destination_day": "",
        "type": ""
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
        console.log("ScreenTicketDelegate::synthesizeFinish()")
        speechScreen.startStopAutoRecording()
    }

    /*
      Функция вызывается при завершении детекции отрезка речи
    */
    function recordFinish(file) {
        console.log("ScreenTicketDelegate::recordFinish()")
        speechScreen.recognizeFile(file)
    }

    /*
      Функция вызывается при успешном распознавании речи
    */
    function recognitionFinsh(records) {
        console.log("ScreenTicketDelegate::recognitionFinsh()")
        if (!mainSpeechControl.processInlineCommands(records)) {
            speechScreen.appendText(messages.get("userName"), records[0])
            speechScreen.synthesize(records[0])
        }
    }

    /*
      Функция вызывается при ошибке распознавания речи
    */
    function recognitionFail(file) {
        console.log("ScreenTicketDelegate::recognitionFail()")
        var text = messages.get("recognitionFail")
        speechScreen.appendText(messages.get("computerName"), text)
        speechScreen.synthesize(text)
    }
}
