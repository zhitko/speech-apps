import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {
    id: header

    property alias backButtonVisible: backButtonImage.visible
    property alias titleText: title.text
    property bool isRecording: false

    signal backButtonClicked()

    RowLayout {
        id: backMenu

        Layout.minimumWidth: parent.width
        anchors.right: parent.right
        anchors.left: parent.left

        height: header.height

        Image {
            id: backButtonImage
            visible: false
            width: header.height
            height: header.height
            source: "qrc:/images/images/Return-32.png"
            MouseArea {
                id: backButton
                anchors.fill: backButtonImage
                onClicked: backButtonClicked()
            }
        }

        Text {
            id: title
            anchors.centerIn: backMenu
            height: header.height
            font.pixelSize: 16
            elide: Text.ElideRight
        }


        Rectangle {
            width: header.height / 2
            height: header.height / 2
            color: header.isRecording ? "#5eff73" : "#00000000"
            anchors.right: parent.right
            radius: height/2
            border.color: "#1d9904"
            border.width: height/10
        }
    }
}
