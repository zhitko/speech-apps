import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {

    property alias isRecording: speechScreen.isRecording
    property string title: qsTr("Translate")

    Component.onCompleted: {
        console.log("ScreenTranslate::show()")
        translateController.translated.connect(translateLogic.translated)

        sourceLanguage.model = settingsController.getSttLanguageList()
        sourceLanguage.currentIndex = settingsController.getSttLanguage()

        destinationVoice.model = settingsController.getTtsVoiceList()
        destinationVoice.currentIndex = settingsController.getTtsVoice()

        destinationLanguage.model = translateController.getLanguageList()
        //destinationLanguage.currentIndex =

        translateLogic.speechScreen = speechScreen
        speechScreen.init()
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
        height: 35

        ComboBox {
            id: sourceLanguage
            anchors.left: parent.left
            height: 32
            textRole: "name"
            onActivated: {
                if(sourceLanguage.model[index]){
                    console.log("Select source language: ", sourceLanguage.model[index].name)
                    settingsController.setSttLanguage(sourceLanguage.model[index].code)
                }
            }
        }

        Image {
            id: translateArrow
            anchors.left: sourceLanguage.right
            height: 32
            source: "qrc:/images/images/Right Arrow-32.png"
        }

        ComboBox {
            id: destinationLanguage
            anchors.left: translateArrow.right
            height: 32
            textRole: "name"
            onActivated: {
                if(destinationLanguage.model[index]){
                    console.log("Select destination language: ", destinationLanguage.model[index].code)
                    speechScreen.destinationLanguage = destinationLanguage.model[index].code
                }
            }
        }

        ComboBox {
            id: destinationVoice
            anchors.left: destinationLanguage.right
            height: 32
            onActivated: {
                if(destinationVoice.model[index]){
                    console.log("Select destination voice: ", destinationVoice.model[index])
                    settingsController.setTtsVoice(destinationVoice.model[index])
                }
            }
        }

        Button {
            id: startTranslate
            anchors.left: destinationVoice.right
            anchors.right: parent.right
            height: 32
            text: qsTr("Start")
            onClicked: {
                console.log("Start translations")
                translateLogic.start()
                startTranslate.enabled = false
            }
        }
    }

    SpeechScreen {
        id: speechScreen
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: languages.bottom
        anchors.bottom: parent.bottom

        delegate: translateLogic

        property string sourceLanguage: "auto"
        property string destinationLanguage

        function translate(text, from, to) {
            translateController.translate(text, from, to)
        }
    }
}

