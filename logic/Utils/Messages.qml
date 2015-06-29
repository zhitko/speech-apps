import QtQuick 2.0

Item {
    property var messages: {

    }

    property var locale: Qt.locale().name

    function get(key, loc) {
        loc = !!loc ? loc : locale
        return messages[loc][key]
    }

    function getRandom(key, loc) {
        loc = !!loc ? loc : locale
        var variants = messages[loc][key];
        var min = 0
        var max = variants.length - 1
        var index = Math.floor(Math.random() * (max - min + 1)) + min
        console.log(index)
        return variants[index]
    }
}

