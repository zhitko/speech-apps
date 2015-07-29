import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

import "Components"

Item {
    id: rootMenu

    property string title: qsTr("Main menu")

    signal menuSelected(string name)

    Component.onCompleted: {
        console.log("rootMenu: Component.onCompleted")
    }

    Menu {
        id: menu
        anchors.fill: parent
        menuDelegate: MenuElement {
            menu: menu
            menuHeight: 80
        }
        menuModel: menuModel
        onMenuSelected: {
            rootMenu.menuSelected(name)
        }
    }

    ListModel {
        id: menuModel
        ListElement {
            image_src: "qrc:/images/images/Chicken-64.png"
            title_text: qsTr("Parrot")
            description_text: qsTr("It will be repeat all your words")
            goto_state: "parrot"
        }
        ListElement {
            image_src: "qrc:/images/images/Talk-64.png"
            title_text: qsTr("White Bull")
            description_text: qsTr("It will be tell White Bull storry tell")
            goto_state: "white-bull"
        }
        ListElement {
            image_src: "qrc:/images/images/Translation-32.png"
            title_text: qsTr("Translate")
            description_text: qsTr("It will be repeat all your words in anouther language")
            goto_state: "translate"
        }
        ListElement {
            image_src: "qrc:/images/images/Ticket-32.png"
            title_text: qsTr("Ticket Marketplace Demo")
            description_text: qsTr("Demo ticket marketplace application with voice interface")
            goto_state: "ticket"
        }
        ListElement {
            image_src: "qrc:/images/images/Calculator-32.png"
            title_text: qsTr("Calculator")
            description_text: qsTr("Calculator application")
            goto_state: "calculator"
        }
        ListElement {
            image_src: "qrc:/images/images/Virgo-32.png"
            title_text: qsTr("Horoscope")
            description_text: qsTr("Voice horoscope assistant")
            goto_state: "horoscope"
        }
        ListElement {
            image_src: "qrc:/images/images/Therapy-32.png"
            title_text: qsTr("Psychoanalyst Eliza Demo")
            description_text: qsTr("Classic chat bot with voice interface")
            goto_state: "psychoanalyst"
        }
    }
}
