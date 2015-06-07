import QtQuick 2.0
import "Components"

Item {
    id: sideMenu
    signal menuSelected(string name)

    visible: false

    function show() {
        sideMenu.visible = true
        anim.start()
    }

    function hide() {
        sideMenu.visible = false
    }

    NumberAnimation {
        id: anim
        target: menuHolder
        from: -menuHolder.width
        to: 0
        properties: "x"
        duration: 200
        easing.type: "InOutExpo"
    }

    Rectangle {
        color: "gray"
        opacity: 0.5
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            onClicked: {
                sideMenu.hide()
            }
        }
    }

    Rectangle {
        id: menuHolder
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        x: 0
        width: parent.width/3*2
        color: "gray"
        Menu {
            id: menu
            anchors.fill: parent
            menuDelegate: MenuElement {
                menu: menu
                menuHeight: 50
            }
            menuModel: menuModel
            onMenuSelected: {
                sideMenu.menuSelected(name)
                sideMenu.hide()
            }
        }

        ListModel {
            id: menuModel
            ListElement {
                image_src: "qrc:/images/images/List-64.png"
                title_text: qsTr("Records")
                description_text: qsTr("View all user records")
                goto_state: "records"
            }
            ListElement {
                image_src: "qrc:/images/images/Settings-64.png"
                title_text: qsTr("Settings")
                description_text: qsTr("Setup all applications settings")
                goto_state: "settings"
            }
            ListElement {
                image_src: "qrc:/images/images/Support-64.png"
                title_text: qsTr("Tests")
                description_text: qsTr("For application tests")
                goto_state: "tests"
            }
        }
    }
}

