import QtQuick 2.4

Item {
    property string id: "parotLogic"

    function external_test() {
        console.log("some test function");
    }

    property Item speechScreen

    property string computerName: qsTr("Computer")
    property string userName: qsTr("User")

    function start() {
        var text = qsTr("Hello, let's start work")
        speechScreen.synthesize(text)
        speechScreen.appendText(computerName, text)
    }

    function synthesizeFinish() {
        console.log("ScreenParrotDelegate::synthesizeFinish()")
        speechScreen.startStopAutoRecording()
    }

    function recordFinish(file) {
        console.log("ScreenParrotDelegate::recordFinish()")
    }

    function recognitionFinsh(records) {
        console.log("ScreenParrotDelegate::recognitionFinsh()")
        speechScreen.appendText(userName, records[0])
        speechScreen.synthesize(records[0])
    }

    function recognitionFail(file) {
        console.log("ScreenParrotDelegate::recognitionFail()")
        var text = qsTr("Not recognized, repeat please")
        speechScreen.appendText(computerName, text)
        speechScreen.synthesize(text)
    }
}
