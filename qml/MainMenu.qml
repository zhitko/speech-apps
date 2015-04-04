import QtQuick 2.4

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

    state: "menu"
    states: [
        State {
            name: "menu"
            PropertyChanges { target: imageListView; visible: true }
            PropertyChanges { target: backMenu; visible: false; height: 0 }
            PropertyChanges { target: screenParrot; visible: false }
            PropertyChanges { target: screenWhiteBull; visible: false }
            PropertyChanges { target: screenSettings; visible: false }
        }
        , State {
            name: "parrot"
            PropertyChanges { target: imageListView; visible: false }
            PropertyChanges { target: backMenu; visible: true; title_text: menuModel.get(0).title_text; }
            PropertyChanges { target: screenParrot; visible: true }
        }
        , State {
            name: "white-bull"
            PropertyChanges { target: imageListView; visible: false }
            PropertyChanges { target: backMenu; visible: true; title_text: menuModel.get(1).title_text; }
            PropertyChanges { target: screenWhiteBull; visible: true }
        }
        , State {
            name: "settings"
            PropertyChanges { target: imageListView; visible: 0 }
            PropertyChanges { target: backMenu; visible: true; title_text: menuModel.get(2).title_text; }
            PropertyChanges { target: screenSettings; visible: true }
        }
    ]

    Item {
        property string title_text: ""

        id: backMenu

        anchors.margins: 5
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left

        height: 32

        Image {
            id: image
            width: 32
            height: 32
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: "qrc:/images/images/Return-32.png"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 32
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height * 0.5
            text: backMenu.title_text
            elide: Text.ElideRight
        }

        MouseArea {
            anchors.fill: image
            onClicked: rootMenu.state = "menu"
        }
    }

    Item {
        anchors.margins: 5
        anchors.top: backMenu.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left

        ScreenParrot {
            id: screenParrot
        }
        ScreenWhiteBull {
            id: screenWhiteBull
        }
        ScreenSettings {
            id: screenSettings
        }

        ListView {
            id: imageListView
            anchors.fill: parent
            model: menuModel
            delegate: mainMenuDelegate.delegate
            clip: true
        }
    }

    MenuItemDelegate {
        id: mainMenuDelegate
        menu: rootMenu
    }
}
