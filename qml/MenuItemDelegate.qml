import QtQuick 2.4

Item {
    property Component delegate: delegateId

    property Item menu

    Component {
        id: delegateId

        BorderImage {
            id: borderImage
            height: 80
            width: parent.width
            border.top: 4
            border.bottom: 4
            source: hitbox.pressed ? "qrc:/images/images/delegate_pressed.png" : "qrc:/images/images/delegate.png"

            Image {
                id: shadow
                anchors.top: parent.bottom
                width: parent.width
                visible: !hitbox.pressed
                source: "qrc:/images/images/shadow.png"
            }

            Image {
                id: image
                width: 64
                height: 64
                anchors.verticalCenter: parent.verticalCenter
                source: image_src
            }

            Column {
                height: parent.height
                anchors.left: image.right
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                Text {
                    height: parent.height / 2
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 25
                    text: title_text
                    elide: Text.ElideRight
                }
                Text {
                    height: parent.height / 2
                    verticalAlignment: Text.AlignTop
                    font.pixelSize: 15
                    text: description_text
                    elide: Text.ElideRight
                    color: "#555"
                }
            }

            MouseArea {
                id: hitbox
                anchors.fill: parent
                onClicked: {
                    menu.state = gotoState
                }
            }
        }
    }
}

