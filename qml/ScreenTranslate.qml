import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {

    property alias isRecording: speechScreen.isRecording
    property string title: qsTr("Translate")

    Component.onCompleted: {
        console.log("ScreenTranslate::show()")
        translateController.translated.connect(translateLogic.translated)

        translateLogic.speechScreen = speechScreen
        speechScreen.init()
        translateLogic.start()
    }

    Component.onDestruction: {
        console.log("ScreenTranslate::free()")
        translateController.translated.disconnect(translateLogic.translated)

        speechScreen.stopRecording()
        speechScreen.free()
    }

    Item {
        id: languages
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 30
    }

    SpeechScreen {
        id: speechScreen
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: languages.bottom
        anchors.bottom: parent.bottom

        delegate: translateLogic

        function translate(text, from, to) {
            translateController.translate(text, from, to)
        }
    }
}

