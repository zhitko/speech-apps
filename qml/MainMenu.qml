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
    }
}
