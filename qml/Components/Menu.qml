import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

Item {
    id: menu

    property ListModel menuModel

    property Item menuDelegate: MenuElement {
        menu: menu
    }

    signal menuSelected(string name)

    ListView {
        anchors.fill: parent
        model: menuModel
        delegate: menuDelegate.delegate
        clip: true
    }
}

