import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {
    id: speechScreenId

    property Item delegate;

    property bool isRecording: false

    property string text: ""

    property bool isAuto: false

    function appendText(actor, text) {
        mainText.append("\n<b>" + actor + "</b>: " + text)
    }

    function setVolume(value) {
        volumeBar.setValue(value)
    }

    function recognizeFile(file) {
        console.log("SpeechScreen::recognizeFile >> " + file )
        speechController.recognizeFile(file)
    }

    function recordFinished(file) {
        console.log("SpeechScreen::recordFinished >> " + file )
        isRecording = false
        delegate.recordFinish(file)
    }

    function recognitionFinsh(file, records) {
        console.log("SpeechScreen::recognitionFinsh " + records);
        if(records.length > 0 && records[0] !== "") {
            delegate.recognitionFinsh(records)
        } else {
            delegate.recognitionFail(file)
        }
    }

    function stopRecording () {
        if (isRecording) {
            console.log("SpeechScreen::stopRecording")
            soundController.stopRecording()
            speechController.recognized.disconnect(recognitionFinsh)
            soundController.recordingFinish.disconnect(recordFinished)
        }
        isRecording = false
    }

    function startStopManualRecording () {
        isAuto = false
        if (isRecording) {
            console.log("SpeechScreen::stopManualRecording")
            soundController.stopRecording()
        } else {
            console.log("SpeechScreen::startManualRecording")
            soundController.startManualRecording()
        }

        isRecording = !isRecording
    }

    function startStopAutoRecording () {
        isAuto = true
        if (isRecording) {
            console.log("SpeechScreen::stopManualRecording")
            soundController.stopRecording()
        } else {
            console.log("SpeechScreen::startManualRecording")
            soundController.startAutoRecording()
        }

        isRecording = !isRecording
    }

    function synthesize (text) {
        console.log("SpeechScreen::synthesize() >> " + text)
        speechController.synthesize(text)
    }

    function synthesizeFinish () {
        console.log("SpeechScreen::synthesizeFinish()")
        delegate.synthesizeFinish()
    }

    function init () {
        console.log("SpeechScreen::init()")
        speechController.recognized.connect(recognitionFinsh)
        speechController.finishSpeaking.connect(synthesizeFinish)
        soundController.recordingFinish.connect(recordFinished)
    }

    function free () {
        console.log("SpeechScreen::free()")
        speechController.recognized.disconnect(recognitionFinsh)
        speechController.finishSpeaking.disconnect(synthesizeFinish)
        soundController.recordingFinish.disconnect(recordFinished)
    }

    RowLayout {
        anchors.fill: parent
        TextArea {
            id: mainText
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            textFormat: TextEdit.RichText
            readOnly: true
            text: speechScreenId.text
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
        ProgressBar {
            id: volumeBar
            Layout.fillHeight: true
            Layout.maximumWidth: 10
            value: 0
            orientation: Qt.Vertical
        }
    }


}
