import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {

    property alias isRecording: speechScreen.isRecording
    property string title: qsTr("Ticket Marketplace Demo")

    Component.onCompleted: {
        console.log("ScreenTicket::show()")
        ticketLogic.speechScreen = speechScreen
        speechScreen.init()
        ticketLogic.start()
    }

    Component.onDestruction: {
        console.log("ScreenTicket::free()")
        speechScreen.stopRecording()
        speechScreen.free()
    }

    SpeechScreen {
        id: speechScreen
        anchors.fill: parent

        text: qsTr("Welcome to Ticket Marketplace Demo")
        delegate: ticketLogic
    }
}

