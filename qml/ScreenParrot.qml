import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {

    property alias isRecording: speechScreen.isRecording
    property string title: qsTr("Parrot")

    Component.onCompleted: {
        console.log("ScreenParrot::show()")
        parotLogic.speechScreen = speechScreen
        speechScreen.init()
        parotLogic.start()
    }

    Component.onDestruction: {
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
}

