import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {
    id: rootMenu
    anchors.fill: parent

    ListModel {
        id: menuModel
        ListElement {
            image_src: "qrc:/images/images/Chicken-64.png"
            title_text: qsTr("Parrot")
            description_text: qsTr("It will be repeat all your words")
            gotoState: "parrot"
        }
        ListElement {
            image_src: "qrc:/images/images/Talk-64.png"
            title_text: qsTr("White Bull")
            description_text: qsTr("It will be tell White Bull storry tell")
            gotoState: "white-bull"
        }
        ListElement {
            image_src: "qrc:/images/images/Settings-64.png"
            title_text: qsTr("Settings")
            description_text: qsTr("Setup all applications settings")
            gotoState: "settings"
        }
    }

    property Item lastScreen

    state: "menu"
    states: [
        State {
            name: "menu"
            PropertyChanges { target: imageListView; visible: true }
            PropertyChanges { target: backMenu; visible: false; height: 0 }
            PropertyChanges { target: screenParrot; visible: false }
            PropertyChanges { target: screenWhiteBull; visible: false }
            PropertyChanges { target: screenSettings; visible: false }
            StateChangeScript {
                name: "onShowParrotScreen"
                script: if(!!rootMenu.lastScreen) rootMenu.lastScreen.free()
            }
        }
        , State {
            name: "parrot"
            PropertyChanges { target: imageListView; visible: false }
            PropertyChanges { target: backMenu; visible: true; title_text: menuModel.get(0).title_text; }
            PropertyChanges { target: screenParrot; visible: true }
            PropertyChanges { target: screenWhiteBull; visible: false }
            PropertyChanges { target: screenSettings; visible: false }
            PropertyChanges { target: rootMenu; lastScreen: screenParrot }
            StateChangeScript {
                name: "onShowParrotScreen"
                script: screenParrot.show()
            }
        }
        , State {
            name: "white-bull"
            PropertyChanges { target: imageListView; visible: false }
            PropertyChanges { target: backMenu; visible: true; title_text: menuModel.get(1).title_text; }
            PropertyChanges { target: screenWhiteBull; visible: true }
            PropertyChanges { target: screenParrot; visible: false }
            PropertyChanges { target: screenSettings; visible: false }
            PropertyChanges { target: rootMenu; lastScreen: screenWhiteBull }
            StateChangeScript {
                name: "onShowWhiteBullScreen"
                script: screenWhiteBull.show()
            }
        }
        , State {
            name: "settings"
            PropertyChanges { target: imageListView; visible: 0 }
            PropertyChanges { target: backMenu; visible: true; title_text: menuModel.get(2).title_text; }
            PropertyChanges { target: screenSettings; visible: true }
            PropertyChanges { target: screenParrot; visible: false }
            PropertyChanges { target: screenWhiteBull; visible: false }
            PropertyChanges { target: rootMenu; lastScreen: screenSettings }
            StateChangeScript {
                name: "onShowSettingsScreen"
                script: screenSettings.show()
            }
        }
    ]

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            property string title_text: ""

            id: backMenu

            Layout.minimumWidth: parent.width

            height: 32

            Image {
                id: image
                width: 32
                height: 32
                source: "qrc:/images/images/Return-32.png"
                MouseArea {
                    anchors.fill: image
                    onClicked: rootMenu.state = "menu"
                }
            }

            Text {
                anchors.centerIn: backMenu

                height: 32
                font.pixelSize: 16
                text: backMenu.title_text
                elide: Text.ElideRight
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            ScreenParrot {
                id: screenParrot
                anchors.fill: parent
            }
            ScreenWhiteBull {
                id: screenWhiteBull
                anchors.fill: parent
            }
            ScreenSettings {
                id: screenSettings
                anchors.fill: parent
            }

            ListView {
                id: imageListView
                anchors.fill: parent
                model: menuModel
                delegate: mainMenuDelegate.delegate
                clip: true
            }

            MenuItemDelegate {
                id: mainMenuDelegate
                menu: rootMenu
            }
        }
    }
}
