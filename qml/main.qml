import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Speech Apps")
    width: 540
    height: 480
    visible: true

    Item {
        id: root
        anchors.fill: parent

        Header {
            id: header
            height: 32
            anchors.margins: 5
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            onBackButtonClicked: {
                root.state = "menu"
            }
            onMenuButtonClicked: {
                sideMenu.show()
            }
        }

        Loader {
            id: loader
            anchors.margins: 5
            anchors.top: header.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            onLoaded: {
            }
        }

        SideMenu {
            id: sideMenu
            anchors.fill: parent
            onMenuSelected: {
                root.state = name
            }
        }

        Connections {
            id: connections
            ignoreUnknownSignals: true
            onMenuSelected: {
                root.state = name
            }
        }

        state: "menu"
        states: [
            State {
                name: "menu"
                PropertyChanges { target: loader; source: "MainMenu.qml"; }
                PropertyChanges { target: header; backButtonVisible: false; }
                PropertyChanges { target: header; titleText: loader.item.title; }
                StateChangeScript {
                    name: "onMenuLoad"
                    script: connections.target = loader.item
                }
            }
            , State {
                name: "parrot"
                PropertyChanges { target: loader; source: "ScreenParrot.qml"; }
                PropertyChanges { target: header; backButtonVisible: true; }
                PropertyChanges { target: header; isRecording: loader.item.isRecording; }
                PropertyChanges { target: header; titleText: loader.item.title; }
            }
            , State {
                name: "white-bull"
                PropertyChanges { target: loader; source: "ScreenWhiteBull.qml"; }
                PropertyChanges { target: header; backButtonVisible: true; }
                PropertyChanges { target: header; isRecording: loader.item.isRecording; }
                PropertyChanges { target: header; titleText: loader.item.title; }
            }
            , State {
                name: "records"
                PropertyChanges { target: loader; source: "ScreenRecords.qml"; }
                PropertyChanges { target: header; backButtonVisible: true; }
                PropertyChanges { target: header; titleText: loader.item.title; }
            }
            , State {
                name: "settings"
                PropertyChanges { target: loader; source: "ScreenSettings.qml"; }
                PropertyChanges { target: header; backButtonVisible: true; }
                PropertyChanges { target: header; titleText: loader.item.title; }
            }
            , State {
                name: "tests"
                PropertyChanges { target: loader; source: "ScreenTests.qml"; }
                PropertyChanges { target: header; backButtonVisible: true; }
                PropertyChanges { target: header; isRecording: loader.item.isRecording; }
                PropertyChanges { target: header; titleText: loader.item.title; }
            }
            , State {
                name: "translate"
                PropertyChanges { target: loader; source: "ScreenTranslate.qml"; }
                PropertyChanges { target: header; backButtonVisible: true; }
                PropertyChanges { target: header; isRecording: loader.item.isRecording; }
                PropertyChanges { target: header; titleText: loader.item.title; }
            }
        ]
    }
}
