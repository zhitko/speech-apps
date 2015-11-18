import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {

    property alias isRecording: speechScreen.isRecording
    property string title: qsTr("Psychoanalyst Eliza Demo")

    function setSpeechControl(mainSpeechControl) {
        console.log("ScreenPsychoanalyst::setSpeechControl()")
        psychoanalystLogic.mainSpeechControl = mainSpeechControl
    }

    Component.onCompleted: {
        console.log("ScreenPsychoanalyst::show()")
        psychoanalystLogic.speechScreen = speechScreen
        speechScreen.init()
        psychoanalystLogic.start()
    }

    Component.onDestruction: {
        console.log("ScreenPsychoanalyst::free()")
        speechScreen.stopRecording()
        speechScreen.free()
    }

    SpeechScreen {
        id: speechScreen
        anchors.fill: parent

        text: qsTr("Welcome to Psychoanalyst Eliza Demo")
        delegate: psychoanalystLogic
    }
}

