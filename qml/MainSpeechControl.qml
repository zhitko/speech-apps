import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {
    id: mainSpeechControl

    property bool isExit: false
    property bool isLoaded: false
    property bool isGotoState
    property string stateName
    property variant statesData

    signal gotoState(string name)

    SpeechScreen {
        id: speechScreen
        delegate: mainSpeechControl
    }

    function startAppSpeechControl() {
        if (isLoaded) {
            console.log("MainSpeechControl::startAppSpeechControl()")
            speechScreen.init()
            mainSpeechControl.start()
        }
    }

    function stopAppSpeechControl() {
        console.log("MainSpeechControl::stopAppSpeechControl()")
        speechScreen.stopRecording()
        speechScreen.free()
    }

// Internal app control logic

    function start() {
        console.log("MainSpeechControl::start()")
        speechScreen.startStopAutoRecording()
    }

    function synthesizeFinish() {
        console.log("MainSpeechControl::synthesizeFinish()")

        if (isExit) {
            Qt.quit()
            return
        }

        if (isGotoState) {
            gotoState(stateName)
            return
        }

        speechScreen.startStopAutoRecording()
    }

    function recordFinish(file) {
        console.log("MainSpeechControl::recordFinish()")
        speechScreen.recognizeFile(file)
    }

    function processInlineCommands(records) {
        console.log("MainSpeechControl::processInlineCommands()")
        if (
            containsAll(records, qsTr("команда назад"))
        ) {
            console.log("MainSpeechControl::processInlineCommands() go back")
            gotoState("menu")
            return true
        } else if (containsAll(records, qsTr("команда конец работы"))) {
            // TODO: check is it work
            console.log("MainSpeechControl::recognitionFinsh() exit")
            speechController.finishSpeaking.connect(speechScreen.synthesizeFinish)
            speechScreen.synthesize(qsTr("ещё увидимся"))
            isExit = true
            return true
        }
        return false
    }

    function recognitionFinsh(records) {
        console.log("MainSpeechControl::recognitionFinsh()")
        var isSynthesize = false;

        isGotoState = false

        if (
            containsAll(records, qsTr("начнем пожалуй"))
        ) {
            console.log("MainSpeechControl::recognitionFinsh() start work")
            isSynthesize = true
            speechScreen.synthesize(qsTr("выберете приложение"))
        } else if (
            containsSome(records, [qsTr("конец работы"), qsTr("завершить работу")])
        ) {
            console.log("MainSpeechControl::recognitionFinsh() exit")
            speechScreen.synthesize(qsTr("ещё увидимся"))
            isExit = true
            isSynthesize = true
        } else {
            for (var state in statesData) {
                if (containsSome(records, statesData[state].paterns)) {
                    console.log("MainSpeechControl::recognitionFinsh() " + state)
                    stateName = state
                    if (statesData[state].message) {
                        isSynthesize = true
                        isGotoState = true
                        speechScreen.synthesize(statesData[state].message)
                    } else {
                        gotoState(stateName)
                    }
                    return
                }
            }
        }

        if (!isSynthesize) speechScreen.startStopAutoRecording()
    }

    function recognitionFail(file) {
        console.log("MainSpeechControl::recognitionFail()")
        speechScreen.startStopAutoRecording()
    }

    function containsAll(where, what) {
        var whatWords = what.toLowerCase().split(" ")
        var whereWords = where.join(" ").toLowerCase().split(" ")
        for (var i = 0; i < whatWords.length; ++i) {
            var isPresent = false
            for (var j = 0; j < whereWords.length; ++j) {
                if (whatWords[i] === whereWords[j]) isPresent = true
            }
            if (!isPresent) return false
        }
        return true
    }

    function containsSome(where, what) {
        for (var i = 0; i < what.length; ++i) {
            if (containsAll(where, what[i])) return true
        }
        return false
    }
}
