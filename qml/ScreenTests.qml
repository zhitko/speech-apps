import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {

    visible: false

    function recognitionFinsh(file, records) {
        console.log("ScreenParrot::recognitionFinsh " + records);
        console.log("ScreenParrot::recognitionFinsh " + records.length);
        if(records.length > 0 && records[0] != "")
            speechScreen.appendText(qsTr("Computer"), records[0])
        else
            speechScreen.appendText(qsTr("Computer"), qsTr("Not recognized, repeat please"))
    }

    function show () {
        console.log("ScreenParrot::show")
        speechController.recognized.connect(recognitionFinsh)
    }

    function free () {
        console.log("ScreenParrot::destroy")
        speechController.recognized.disconnect(recognitionFinsh)
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
                    console.log("ScreenParrot::recording")
                    speechScreen.startStopManualRecording()
                }
            }

            Button {
                iconSource: "qrc:/images/images/Speaker-32.png"
                onClicked: {
                    var files = fileController.getFileList()
                    if (files.length > 0)
                    {
                        console.log("ScreenParrot::play >> " + files[0].name)
                        soundController.playFile(files[0].name)
                    }
                }
            }

            Button {
                iconSource: "qrc:/images/images/Talk-64.png"
                onClicked: {
                    var files = fileController.getFileList()
                    if (files.length > 0)
                    {
                        console.log("ScreenParrot::recognize >> " + files[0].name)
                        speechController.recognizeFile(files[0].name)
                    }
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }
    }
}

