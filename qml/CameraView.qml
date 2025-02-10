import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtMultimedia 5.12
import QtGraphicalEffects 1.12

Item {
    id: cameraView
    anchors.fill: parent

    // Background Image (Same as Main UI)
    Image {
        source: "qrc:/images/background.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    // Back Button
    MouseArea {
        width: 50
        height: 50
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
        onClicked: stackView.pop();  // Go back to Assist Screen

        Image {
            source: "qrc:/images/back.png"
            width: 40
            height: 40
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
        }
    }

    // Camera Video Feed
    Rectangle {
        width: parent.width * 0.8
        height: parent.height * 0.6
        color: "black"
        anchors.centerIn: parent

        // Camera Output (GStreamer)
        GStreamer {
            id: cameraStream
            anchors.fill: parent
            pipeline: "v4l2src device=/dev/video0 ! image/jpeg ! jpegdec ! autovideosink"
        }
    }
}
