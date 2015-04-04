import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {
    id: speechScreenId

    property string text: ""

    function appendText(actor, text) {
        mainText.append("\n<b>" + actor + "</b>: " + text)
    }

    function setVolume(value) {
        volumeBar.setValue(value)
    }

    anchors.fill: parent

    RowLayout {
        anchors.fill: parent
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
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

            RowLayout {
                id: inputRow
                height: 32
                spacing: 5
                Layout.fillWidth: true

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
                        appendText(qsTr("User"), text)
                        text = "";
                    }
                }
            }
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
