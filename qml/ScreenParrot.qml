import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {

    visible: false

    function show () {
        console.log("ScreenParrot::show()")
        speechScreen.init()
        speechScreen.startStopAutoRecording()
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
    }
}

