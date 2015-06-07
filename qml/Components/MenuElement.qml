import QtQuick 2.4

Item {
    id: menuElement

    property Component delegate: delegateId

    property Item menu

    property int menuHeight: 40
    property int menuMargin: 10

    Component {
        id: delegateId

        BorderImage {
            id: borderImage
            height: menuHeight
            width: parent.width
            border.top: 4
            border.bottom: 4
            source: hitbox.pressed ? "qrc:/images/images/delegate_pressed.png" : "qrc:/images/images/delegate.png"

            MouseArea {
                id: hitbox
                anchors.fill: parent
                onClicked: {
                    menu.menuSelected(goto_state)
                }
            }

            Image {
                id: image
                width: parent.height - 2*menuMargin
                height: parent.height - 2*menuMargin
                anchors.verticalCenter: parent.verticalCenter
                source: image_src
            }

            Column {
                height: parent.height
                anchors.left: image.right
                anchors.right: parent.right
                anchors.rightMargin: menuMargin
                anchors.leftMargin: menuMargin
                Text {
                    height: description_text ? parent.height / 2 : parent.height
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 20
                    text: title_text
                    elide: Text.ElideRight
                }
                Text {
                    visible: description_text
                    height: parent.height / 2
                    verticalAlignment: Text.AlignTop
                    font.pixelSize: 15
                    text: description_text
                    elide: Text.ElideRight
                }
            }
        }
    }
}

