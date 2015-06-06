import QtQuick 2.0

Item {
    property var messages: {

    }

    function get(key) {
        return messages[Qt.locale().name][key]
    }

    function getRandom(key) {
        var variants = messages[Qt.locale().name][key];
        var min = 0
        var max = variants.length - 1
        var index = Math.floor(Math.random() * (max - min + 1)) + min
        console.log(index)
        return variants[index]
    }
}

