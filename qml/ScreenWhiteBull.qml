import QtQuick 2.4
import QtQuick.Layouts 1.0

Item {

    function show () {
        console.log("ScreenWhiteBull::show()")
        speechController.startRecording()
    }

    function free () {
        console.log("ScreenWhiteBull::destroy()")
        speechController.stopRecording()
    }

    ColumnLayout {
        anchors.fill: parent

        SpeechScreen {
            id: speechScreen
            Layout.minimumWidth: parent.width
            Layout.fillHeight: true

            text: "Hello White Bull"
        }

        RowLayout {
            id: inputRow
            height: 32
            spacing: 5
            Layout.minimumWidth: parent.width

            Image {
                id: inputImage
                Layout.maximumHeight: 32
                Layout.maximumWidth: 32
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/images/Talk-64.png"
            }

            TextInput {
                id: userInput
                Layout.fillWidth: true
                Layout.maximumHeight: 32
                clip: true
                font.pixelSize: 20
                verticalAlignment: Text.AlignVCenter
                onAccepted: {
                    speechScreen.appendText(qsTr("User"), text)
                    text = "";
                }
            }
        }
    }
}

