import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {

    function show () {
        console.log("ScreenParrot::show()")
    }

    function free () {
        console.log("ScreenParrot::destroy()")
    }

    ColumnLayout {
        anchors.fill: parent

        SpeechScreen {
            id: speechScreen
            Layout.minimumWidth: parent.width
            Layout.fillHeight: true

            text: qsTr("Voice recognition test")
        }

        RowLayout {
            id: inputRow
            height: 32
            spacing: 5
            Layout.minimumWidth: parent.width

            Button {
                iconSource: speechScreen.isRecording ? "qrc:/images/images/Microphone-32 (1).png"
                                                     : "qrc:/images/images/Microphone-32.png"
                onClicked: {
                    speechScreen.startStopManualRecording()
                }
            }
        }
    }
}

