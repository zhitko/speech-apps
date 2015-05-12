import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {

    visible: false

    function show () {
        console.log("ScreenParrot::show()")
        speechScreen.init()
        parotLogic.start()
    }

    function free () {
        console.log("ScreenParrot::free()")
        speechScreen.stopRecording()
        speechScreen.free()
    }

    SpeechScreen {
        id: speechScreen
        anchors.fill: parent

        text: qsTr("Voice recognition test")
        delegate: parotLogic
    }

    Item {
        id: parotLogic

        property string computerName: qsTr("Computer")
        property string userName: qsTr("User")

        function start() {
            var text = qsTr("Hello, let's start work")
            speechScreen.synthesize(text)
            speechScreen.appendText(computerName, text)
        }

        function synthesizeFinish() {
            console.log("ScreenParrotDelegate::synthesizeFinish()")
            speechScreen.startStopAutoRecording()
        }

        function recordFinish(file) {
            console.log("ScreenParrotDelegate::recordFinish()")
        }

        function recognitionFinsh(records) {
            console.log("ScreenParrotDelegate::recognitionFinsh()")
            speechScreen.appendText(userName, records[0])
            speechScreen.synthesize(records[0])
        }

        function recognitionFail(file) {
            console.log("ScreenParrotDelegate::recognitionFail()")
            var text = qsTr("Not recognized, repeat please")
            speechScreen.appendText(computerName, text)
            speechScreen.synthesize(text)
        }
    }
}

