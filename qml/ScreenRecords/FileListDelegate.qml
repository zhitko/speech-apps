import QtQuick 2.4

Item {
    property Component delegate: delegateId

    property Item controlDelegate

    Component {
        id: delegateId

        BorderImage {
            id: borderImage
            height: 40
            width: parent.width
            border.top: 4
            border.bottom: 4
            source: "qrc:/images/images/delegate_pressed.png"

            Image {
                id: image
                width: 32
                height: 32
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/images/Audio Wave-32.png"
            }

            Column {
                height: parent.height
                anchors.left: image.right
                anchors.right: controls.right
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                Text {
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 20
                    text: modelData
                    elide: Text.ElideRight
                }
            }

            MouseArea {
                id: hover
                hoverEnabled: true
                anchors.fill: parent
            }

            Row {
                id: controls
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                visible: hover.containsMouse

                Image {
                    id: playImage
                    width: 32
                    height: 32
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/images/images/Play-32.png"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("FileListDelegate::playFile >> " + modelData)
                            controlDelegate.playFile(modelData)
                        }
                    }
                }

                Image {
                    id: deleteImage
                    width: 32
                    height: 32
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/images/images/Delete-32.png"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("FileListDelegate::deleteFile >> " + modelData)
                            controlDelegate.deleteFile(modelData)
                        }
                    }
                }
            }
        }
    }
}

