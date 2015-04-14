import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

import "ScreenRecords"

Item {

    visible: false

    function recognitionFinsh(records) {
        console.log("ScreenRecords::recognitionFinsh" + records);
        updateFileList()
    }

    function show () {
        console.log("ScreenRecords::show")
        updateFileList()
        speechController.recognized.connect(recognitionFinsh)
    }

    function free () {
        console.log("ScreenRecords::destroy")
        speechController.recognized.disconnect(recognitionFinsh)
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

