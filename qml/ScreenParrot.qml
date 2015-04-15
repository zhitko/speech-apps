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

    SpeechScreen {
        id: speechScreen
        anchors.fill: parent

        text: qsTr("Voice recognition test")
    }
}

