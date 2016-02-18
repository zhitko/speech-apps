import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Speech Apps")
    width: 540
    height: 480
    visible: true

    function gotoState(name) {
        console.log("gotoState " + name)
        mainSpeechControl.stopAppSpeechControl()
        root.state = name
    }

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
                if (item.setSpeechControl)
                    item.setSpeechControl(mainSpeechControl)
            }
        }

        SideMenu {
            id: sideMenu
            anchors.fill: parent
            onMenuSelected: {
                gotoState(name)
            }
        }

        Connections {
            id: connectionsMenu
            ignoreUnknownSignals: true
            onMenuSelected: {
                gotoState(name)
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
                    script: {
                        connectionsMenu.target = loader.item
                        mainSpeechControl.startAppSpeechControl()
                    }
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
            , State {
                name: "ticket"
                PropertyChanges { target: loader; source: "ScreenTicket.qml"; }
                PropertyChanges { target: header; backButtonVisible: true; }
                PropertyChanges { target: header; isRecording: loader.item.isRecording; }
                PropertyChanges { target: header; titleText: loader.item.title; }
            }
            , State {
                name: "horoscope"
                PropertyChanges { target: loader; source: "ScreenHoroscope.qml"; }
                PropertyChanges { target: header; backButtonVisible: true; }
                PropertyChanges { target: header; isRecording: loader.item.isRecording; }
                PropertyChanges { target: header; titleText: loader.item.title; }
            }
            , State {
                name: "calculator"
                PropertyChanges { target: loader; source: "ScreenCalculator.qml"; }
                PropertyChanges { target: header; backButtonVisible: true; }
                PropertyChanges { target: header; isRecording: loader.item.isRecording; }
                PropertyChanges { target: header; titleText: loader.item.title; }
            }
            , State {
                name: "psychoanalyst"
                PropertyChanges { target: loader; source: "ScreenPsychoanalyst.qml"; }
                PropertyChanges { target: header; backButtonVisible: true; }
                PropertyChanges { target: header; isRecording: loader.item.isRecording; }
                PropertyChanges { target: header; titleText: loader.item.title; }
            }
        ]

        MainSpeechControl {
            id: mainSpeechControl
            objectName: "mainSpeechControl"
            statesData: {
                "menu" : {
                    "paterns": [qsTr("меню"), qsTr("назад")]
                }
                , "parrot" : {
                    "paterns": [qsTr("телеграф"), qsTr("попугай")]
                    , "message": qsTr("запуск телеграфа")
                }
                , "white-bull" : {
                    "paterns": [qsTr("бычок"), qsTr("сказка"), qsTr("сказку")]
                    , "message": qsTr("запуск сказки белый бычок")
                }
    //            , "records" : {
    //                "paterns": [qsTr("записи")]
    //            }
                , "settings" : {
                    "paterns": [qsTr("настройки")]
                }
    //            , "tests" : {
    //                "paterns": [qsTr("тесты")]
    //                , "message": qsTr("запуск тестов")
    //            }
                , "translate" : {
                    "paterns": [qsTr("переводчик")]
                    , "message": qsTr("запуск переводчика")
                }
                , "ticket" : {
                    "paterns": [qsTr("билеты"), qsTr("билетов"), qsTr("билет")]
                    , "message": qsTr("запуск подбора билетов")
                }
    //            , "horoscope" : {
    //                "paterns": [qsTr("гороскоп")]
    //                , "message": qsTr("запуск гороскопа")
    //            }
                , "calculator" : {
                    "paterns": [qsTr("калькулятор")]
                    , "message": qsTr("запуск калькулятора")
                }
    //            , "psychoanalyst" : {
    //                "paterns": [qsTr("прихоаналитик")]
    //                , "message": qsTr("запуск психоаналитика")
    //            }
            }
        }

        Connections {
            id: connectionsSpeech
            target: mainSpeechControl
            onGotoState: {
                gotoState(name)
            }
        }
    }
}
