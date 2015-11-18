import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {

    property alias isRecording: speechScreen.isRecording
    property string title: qsTr("Calculator")

    function setSpeechControl(mainSpeechControl) {
        console.log("ScreenCalculator::setSpeechControl()")
        calculatorLogic.mainSpeechControl = mainSpeechControl
    }

    Component.onCompleted: {
        console.log("ScreenCalculator::show()")
        calculatorLogic.speechScreen = speechScreen
        speechScreen.init()
        calculatorLogic.start()
    }

    Component.onDestruction: {
        console.log("ScreenCalculator::free()")
        speechScreen.stopRecording()
        speechScreen.free()
    }

    SpeechScreen {
        id: speechScreen
        anchors.fill: parent

        text: qsTr("Welcome to Calculator")
        delegate: calculatorLogic
    }
}

