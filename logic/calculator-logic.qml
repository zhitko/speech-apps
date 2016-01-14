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
    property Item mainSpeechControl

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
                , "greetings": "Могу рассчитать любую формулу"
                , "error": "Не удалось рассчитать формулу"
                , "parse": parseRu
                , "eval": evalRu
                , "split": splitRu
                , "generate": generateRu
                , "resultAnswer": "Результат вычисления, равен %1"
                , "stemmer": "russian"
            }
            , "en_US": {
                "computerName": "Computer"
                , "userName": "User"
                , "recognitionFail": "Not recognized, repeat please"
                , "greetings": "2x2=4"
                , "error": "Can't parse it"
                , "parse": parseEn
                , "eval": evalEn
                , "split": splitEn
                , "generate": generateEn
                , "resultAnswer": "Result is %1"
                , "stemmer": "english"
            }
        }
    }

    property var stemmer
    property var parser

    FileIO {
        id: grammar
//        source: "./release/logic/calculator/grammar.peg"
        source: "./logic/calculator/grammar.peg"
        onError: console.log(msg)
    }

    function test() {
        var texts = [
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
                    , "возвести 2 в степень 3"
                ]
        for (var i=0; i<texts.length; ++i) {
            var phrase = texts[i]
            speechScreen.appendText(messages.get("userName"), phrase)
            var result = processInput(phrase)
            speechScreen.appendText(messages.get("computerName"), result)
        }
    }

    function processInput(phrase) {
        console.log("Input \t" + phrase)
        var query = messages.get("parse")(phrase)
        console.log("Math  \t" + query)

        var result = messages.get("eval")(query)
        console.log("Result \t" + result)

        var answer = messages.get("generate")(result)
        console.log("Answer \t" + result)

        var outText = query + " = " + result

        return [outText, answer]
    }

    function parseRu(text) {
        var addWords = ["+","плюс","добавить","сложить","прибавить","сумма","plus"]
        var substractWords = ["-","минус","отнять","вычесть"]
        var multiplyWords = ["*","умножить","произведение"]
        var divideWords = ["/","делить","разделить","деление","поделить"]
        var powerWords = ["^","степень"]

        var word1 = ["один","единица"]
        var word2 = ["два","двойка"]
        var word3 = ["три","тройка"]
        var word4 = ["четыре","терверка"]
        var word5 = ["пять","пятерка","пятёрка"]
        var word6 = ["шесть","шестерка","шестёрка"]
        var word7 = ["семь","семерка","семёрка"]
        var word8 = ["восемь","восьмерка","восьмёрка"]
        var word9 = ["девять","девятка"]
        var word0 = ["ноль"]

        var operatorMap = {}

        fillOperator(operatorMap, addWords, "+")
        fillOperator(operatorMap, substractWords, "-")
        fillOperator(operatorMap, multiplyWords, "*")
        fillOperator(operatorMap, divideWords, "/")
        fillOperator(operatorMap, powerWords, "^")
        fillOperator(operatorMap, word1, "1")
        fillOperator(operatorMap, word2, "2")
        fillOperator(operatorMap, word3, "3")
        fillOperator(operatorMap, word4, "4")
        fillOperator(operatorMap, word5, "5")
        fillOperator(operatorMap, word6, "6")
        fillOperator(operatorMap, word7, "7")
        fillOperator(operatorMap, word8, "8")
        fillOperator(operatorMap, word9, "9")
        fillOperator(operatorMap, word0, "0")

        var inWords = messages.get("split")(text)

        var stemmedWords = stemmerThem(inWords)

        var processedWords = []

        for (var i=0; i<stemmedWords.length; ++i) {
            var word = stemmedWords[i].toLowerCase()
            var operator = operatorMap[word]
            if (!!operator) processedWords.push(operator)
            else if (!isNaN(word)) processedWords.push(word)
        }

        if (!parser) parser = PEG.PEG.buildParser(grammar.read())
        console.log("Peg << \t" + processedWords.join(" "))
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

    function generateRu(result) {
        var re = new RegExp("%1", 'g');
        var answer = messages.get("resultAnswer").replace(re, result)
        return answer
    }

    function generateEn(result) {
        var re = new RegExp("%1", 'g');
        var answer = messages.get("resultAnswer").replace(re, result)
        return answer
    }

    /*
      Функция вызывается при старте режима
    */
    function start() {
        if (!stemmer) stemmer = Snowball.Snowball(messages.get("stemmer"))
        var text = messages.get("greetings")
        speechScreen.synthesize(text)
        speechScreen.appendText(messages.get("computerName"), text)

//        test()
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
        if (!mainSpeechControl.processInlineCommands(records)) {
            var sentense = findBest(records)

            speechScreen.appendText(messages.get("userName"), sentense)
            var result = [messages.get("error"),messages.get("error")]
            try {
                result = processInput(sentense)
            }
            catch(err) {
                console.log(err)
            }

            speechScreen.appendText(messages.get("computerName"), result[0])

            speechScreen.synthesize(result[1])
        }
    }

    function isDigit(letter) {
        return !isNaN(parseInt(letter, 10))
    }

    function findBest(list) {
        var best = {};
        best.mark = -1;
        best.index = 0;
        var mark = 0;
        for (var i=0; i<list.length; ++i) {
            for (var j=0; j<list[i].length; j++)
                if (isDigit(list[i][j]))
                    mark++
            if (best.mark < mark) {
                best.index = i
                best.mark = mark
            }
            mark = 0
        }
        return list[best.index]
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
