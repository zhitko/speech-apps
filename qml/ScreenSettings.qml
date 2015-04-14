import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

Item {

    visible: false

    function show () {
        console.log("ScreenSettings::show()")

        inputDevices.model = settingsController.getInputDeviceList()
        inputDevices.currentIndex = settingsController.getInputDevice()

        outputDevices.model = settingsController.getOutputDeviceList()
        outputDevices.currentIndex = settingsController.getOutputDevice()

        uiLanguages.model = settingsController.getUiLanguageList()
        uiLanguages.currentIndex = settingsController.getUiLanguage()
        sttLangages.model = settingsController.getSttLanguageList()
        sttLangages.currentIndex = settingsController.getSttLanguage()
        ttsLanguages.model = settingsController.getTtsLanguageList()
        ttsLanguages.currentIndex = settingsController.getTtsLanguage()
    }

    function free () {
        console.log("ScreenSettings::destroy()")
        settingsController.saveSettings()
    }

    ColumnLayout {
        anchors.fill: parent

        GroupBox {
            title: qsTr("Input audio device")
            Layout.fillWidth: true
            ComboBox {
                id: inputDevices
                anchors.left: parent.left
                anchors.right: parent.right
                textRole: "name"
                onActivated: {
                    if(inputDevices.model[index]){
                        console.log("Select input device: ", inputDevices.model[index].name)
                        settingsController.setInputDevice(inputDevices.model[index].index)
                    }
                }
            }
        }

        GroupBox {
            title: qsTr("Output audio device")
            Layout.fillWidth: true
            ComboBox {
                id: outputDevices
                anchors.left: parent.left
                anchors.right: parent.right
                textRole: "name"
                onActivated: {
                    if(outputDevices.model[index]){
                        console.log("Select output device: ", outputDevices.model[index].name)
                        settingsController.setOutputDevice(outputDevices.model[index].index)
                    }
                }
            }
        }

        GroupBox {
            title: qsTr("Language")
            Layout.fillWidth: true
            ColumnLayout {
                anchors.fill: parent

                GroupBox {
                    title: qsTr("User interface")
                    Layout.fillWidth: true
                    ComboBox {
                        id: uiLanguages
                        anchors.left: parent.left
                        anchors.right: parent.right
                        textRole: "name"
                        onActivated: {
                            if(uiLanguages.model[index]){
                                console.log("Select language: ", uiLanguages.model[index].name)
                                settingsController.setUiLanguage(uiLanguages.model[index].code)
                            }
                        }
                    }
                }
                GroupBox {
                    title: qsTr("Text to speech")
                    Layout.fillWidth: true
                    ComboBox {
                        id: ttsLanguages
                        anchors.left: parent.left
                        anchors.right: parent.right
                        textRole: "name"
                        onActivated: {
                            if(ttsLanguages.model[index]){
                                console.log("Select language: ", ttsLanguages.model[index].name)
                                settingsController.setTtsLanguage(ttsLanguages.model[index].code)
                            }
                        }
                    }
                }
                GroupBox {
                    title: qsTr("Speech to text")
                    Layout.fillWidth: true
                    ComboBox {
                        id: sttLangages
                        anchors.left: parent.left
                        anchors.right: parent.right
                        textRole: "name"
                        onActivated: {
                            if(sttLangages.model[index]){
                                console.log("Select language: ", sttLangages.model[index].name)
                                settingsController.setSttLanguage(sttLangages.model[index].code)
                            }
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}

