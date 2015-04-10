import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0

import "ScreenRecords"

Item {

    visible: false

    function show () {
        console.log("ScreenRecords::show()")
        updateFileList()
    }

    function free () {
        console.log("ScreenRecords::destroy()")
    }

    function updateFileList () {
        imageListView.model = fileController.getFileList()
    }

    ListView {
        id: imageListView
        anchors.fill: parent
        model: fileController.getFileList()
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
    }
}

