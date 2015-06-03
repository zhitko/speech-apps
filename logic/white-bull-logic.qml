import QtQuick 2.4

Item {
    property string id: "whiteBullLogic"

    property string computerName: qsTr("Computer")
    property string userName: qsTr("User")

    property Item speechScreen

    function start() {
        var text = qsTr("Хочешь? Я Расскажу тебе сказку про белого бычка.")
        speechScreen.synthesize(text)
        speechScreen.appendText(computerName, text)
    }

    function synthesizeFinish() {
        console.log("ScreenWhiteBullDelegate::synthesizeFinish()")
        speechScreen.startStopAutoRecording()
    }

    function recordFinish(file) {
        console.log("ScreenWhiteBullDelegate::recordFinish()")
    }

    function recognitionFinsh(records) {
        console.log("ScreenWhiteBullDelegate::recognitionFinsh()")
        speechScreen.appendText(userName, records[0])
        var variants = [
                    qsTr("Ты %1, я %1. Хочешь? Я Расскажу тебе сказку про белого бычка.").arg(records[0])
                    , qsTr("Ты говоришь: %1, я говорю: %1. Рассказать ли тебе сказку про белого бычка?").arg(records[0])
                ]
        console.log(variants)
        var min = 0
        var max = variants.length - 1
        var index = Math.floor(Math.random() * (max - min + 1)) + min
        console.log(index)
        var text = variants[index]
        console.log(text)
        speechScreen.appendText(computerName, text)
        speechScreen.synthesize(text)
    }

    function recognitionFail(file) {
        console.log("ScreenWhiteBullDelegate::recognitionFail()")
        var text = qsTr("Фраза не распознана, пожалуйста повторите.")
        speechScreen.appendText(computerName, text)
        speechScreen.synthesize(text)
    }
}
