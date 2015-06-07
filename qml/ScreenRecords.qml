import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

import "ScreenRecords"

Item {
    property string title: qsTr("Records")

    Component.onCompleted: {
        console.log("ScreenRecords::show")
        updateFileList()
        speechController.recognized.connect(recognitionFinsh)
    }

    Component.onDestruction: {
        console.log("ScreenRecords::destroy")
        speechController.recognized.disconnect(recognitionFinsh)
    }

    function recognitionFinsh(file, records) {
        console.log("ScreenRecords::recognitionFinsh" + records)
        if(records.length > 0 && records[0] !== "") {
            fileController.setFileTranslation(file, records[0])
        }
        updateFileList()
    }

    function updateFileList () {
        console.log("ScreenRecords::updateFileList")
        var files = fileController.getFileList()
        imageListView.model = files
    }

    ListView {
        id: imageListView
        anchors.fill: parent
        delegate: fileListDelegate.delegate
        clip: true
    }

    FileListDelegate {
        id: fileListDelegate
        controlDelegate: fileControls
    }

    Item {
        id: fileControls

        function playFile(file) {
            console.log("ScreenRecords::playFile >> " + file)
            soundController.playFile(file)
        }

        function deleteFile(file) {
            console.log("ScreenRecords::deleteFile >> " + file)
            fileController.deleteFile(file)
            updateFileList()
        }

        function recognizeFile(file) {
            console.log("ScreenRecords::recognizeFile >> " + file)
            speechController.recognizeFile(file);
        }
    }
}

