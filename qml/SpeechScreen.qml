import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {
    id: speechScreenId

    property bool isRecording: false

    property string text: ""

    function appendText(actor, text) {
        mainText.append("\n<b>" + actor + "</b>: " + text)
    }

    function setVolume(value) {
        volumeBar.setValue(value)
    }

    function startStopManualRecording () {
        if (isRecording) {
            console.log("SpeechScreen::stopManualRecording")
            soundController.stopRecording()
        } else {
            console.log("SpeechScreen::startManualRecording")
            soundController.startRecording()
        }

        isRecording = !isRecording
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
