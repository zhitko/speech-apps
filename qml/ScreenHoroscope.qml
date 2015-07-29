import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {

    property alias isRecording: speechScreen.isRecording
    property string title: qsTr("Horoscope")

    Component.onCompleted: {
        console.log("ScreenHoroscope::show()")
        horoscopeLogic.speechScreen = speechScreen
        speechScreen.init()
        horoscopeLogic.start()
    }

    Component.onDestruction: {
        console.log("ScreenHoroscope::free()")
        speechScreen.stopRecording()
        speechScreen.free()
    }

    SpeechScreen {
        id: speechScreen
        anchors.fill: parent

        text: qsTr("Welcome to Horoscope")
        delegate: horoscopeLogic
    }
}

