import QtQuick 2.4
import FileIO 1.0

import "Utils"

import "external/mathjs/math.js" as Mathjs
import "external/urim/Snowball.js" as Snowball
import "external/PEGjs/peg-0.8.0.js" as PEG

Item {
    property string id: "calculatorLogic"

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
                "computerName": "Компьютер"
                , "userName": "Пользователь"
                , "recognitionFail": "Фраза не распознана, пожалуйста повторите."
                , "greetings": "2+2=4"
                , "parse": parseRu
                , "eval": evalRu
                , "split": splitRu
                , "stemmer": "russian"
            }
            , "en_US": {
                "computerName": "Computer"
                , "userName": "User"
                , "recognitionFail": "Not recognized, repeat please"
                , "greetings": "2x2=4"
                , "parse": parseEn
                , "eval": evalEn
                , "split": splitEn
                , "stemmer": "english"
            }
        }
    }

    property var stemmer
    property var parser

    FileIO {
        id: grammar
        source: "./logic/calculator/grammar.peg"
        onError: console.log(msg)
    }

    function test() {
        var texts = [
//                    "2 + 2"
//                    , "2 * 3"
//                    , "2 + 3 * 4"
//                    , "(2 + 3) * 4"
                    "2 плюс 2"
                    , "сложить 2 и 3"
                    , "к 2 добавить 5"
                    , "10 минус 2"
                    , "из 5 вычесть 3"
                    , "от 3 отнять 1"
                    , "3 умножить на 2"
                    , "найти произведение 3 и 5"
                    , "10 делить на 2"
                    , "15 разделить на 3"
                    , "найти результат деления 10 на 2"
                    , "5 умножить на 2 и прибавить 10"
                    , "сложить 5 и 2 затем умножить результат на 10 и добавить 3"
                    , "10 разделить на сумму 3 и 2"
                ]
        for (var i=0; i<texts.length; ++i) {
            var inText = texts[i]
            speechScreen.appendText(messages.get("userName"), inText)
            var query = messages.get("parse")(inText)
            var result = messages.get("eval")(query)
            var outText = query + " = " + result
            speechScreen.appendText(messages.get("computerName"), outText)
        }
    }

    function parseRu(text) {
        var addWords = ["плюс","добавить","сложить","прибавить","сумма"]
        var substractWords = ["минус","отнять","вычесть"]
        var multiplyWords = ["умножить","произведение"]
        var divideWords = ["делить","разделить","деление"]
        var powerWords = ["степень","возвести"]

        var operatorMap = {}

        fillOperator(operatorMap, addWords, "+")
        fillOperator(operatorMap, substractWords, "-")
        fillOperator(operatorMap, multiplyWords, "*")
        fillOperator(operatorMap, divideWords, "/")
        fillOperator(operatorMap, powerWords, "^")

        var inWords = messages.get("split")(text)

        var stemmedWords = stemmerThem(inWords)

        var processedWords = []

        for (var i=0; i<stemmedWords.length; ++i) {
            var word = stemmedWords[i]
            var operator = operatorMap[word]
            if (!!operator) processedWords.push(operator)
            else if (!isNaN(word)) processedWords.push(word)
        }

        if (!parser) parser = PEG.PEG.buildParser(grammar.read())
        var mathQuery = parser.parse(processedWords.join(" "))

        return mathQuery
    }

    function fillOperator(map, words, operator) {
        for (var i=0; i<words.length; ++i) {
            stemmer.setCurrent(words[i]);
            stemmer.stem();
            map[stemmer.getCurrent()] = operator
        }
        return map
    }

    function stemmerThem(words) {
        var processed = []
        for (var i=0; i<words.length; ++i) {
            stemmer.setCurrent(words[i]);
            stemmer.stem();
            processed.push(stemmer.getCurrent());
        }
        return processed
    }

    function parseEn(text) {
        return text
    }

    function evalRu(query) {
        return Mathjs.eval(query)
    }

    function evalEn(query) {
        return Mathjs.eval(query)
    }

    function splitRu(text) {
        return text.split(" ")
    }

    function splitEn(text) {
        return text.split(" ")
    }

    /*
      Функция вызывается при старте режима
    */
    function start() {
        if (!stemmer) stemmer = Snowball.Snowball(messages.get("stemmer"))
//        var text = messages.get("greetings")
//        speechScreen.synthesize(text)
//        speechScreen.appendText(messages.get("computerName"), text)
        test()
    }

    /*
      Функция вызывается при завершении синтеза речи
    */
    function synthesizeFinish() {
        console.log("ScreenCalculatorDelegate::synthesizeFinish()")
        speechScreen.startStopAutoRecording()
    }

    /*
      Функция вызывается при завершении детекции отрезка речи
    */
    function recordFinish(file) {
        console.log("ScreenCalculatorDelegate::recordFinish()")
        speechScreen.recognizeFile(file)
    }

    /*
      Функция вызывается при успешном распознавании речи
    */
    function recognitionFinsh(records) {
        console.log("ScreenCalculatorDelegate::recognitionFinsh()")
        speechScreen.appendText(messages.get("userName"), records[0])
        speechScreen.synthesize(records[0])
    }

    /*
      Функция вызывается при ошибке распознавания речи
    */
    function recognitionFail(file) {
        console.log("ScreenCalculatorDelegate::recognitionFail()")
        var text = messages.get("recognitionFail")
        speechScreen.appendText(messages.get("computerName"), text)
        speechScreen.synthesize(text)
    }
}
