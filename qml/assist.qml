import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12  // Required for text shadows

Item {
    id: assist
    width: parent.width
    height: parent.height

    // Main background color, same as Main UI
    Image {
        source: "qrc:/images/background.jpg"  // Reuse the background image as in main UI and MediaPlayer UI
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    // Weather info at the top-right
    Text {
        id: weatherInfo
        text: "Weather: 25°C"
        font.pixelSize: 20
        color: "#111111"  // Light gray color for better readability
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20

        layer.enabled: true
        layer.effect: DropShadow {
            color: "#888888"
            radius: 10
            samples: 16
            verticalOffset: 2
            horizontalOffset: 2
        }
    }

    // Date & Time in the top-left
    Text {
        id: dateTime
        text: Qt.formatDateTime(new Date(), "dddd, dd MMM yyyy - hh:mm AP")
        font.pixelSize: 24
        font.bold: true
        color: "#111111"  // Light gray color for consistency
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20

        // Shadow effect for readability
        layer.enabled: true
        layer.effect: DropShadow {
            color: "#888888"
            radius: 10
            samples: 16
            verticalOffset: 2
            horizontalOffset: 2
        }

        // Update time every second
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: dateTime.text = Qt.formatDateTime(new Date(), "dddd, dd MMM yyyy - hh:mm AP")
        }
    }

    // Back button on the top-left (Only showing icon like in MediaPlayer.qml)
    MouseArea {
        width: 50
        height: 50
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
        onClicked: {
            // Navigate back to the main UI
            stackView.pop();
        }

        Image {
            source: "qrc:/images/back.png"  // Only the back icon
            width: 40
            height: 40
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
        }
    }

    // Title in the center of the top
    Text {
        text: "Driving Assistance"
        font.pixelSize: 32
        font.bold: true
        color: "#111111"  // Light gray color for readability
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 60  // Spacing from the top

        layer.enabled: true
        layer.effect: DropShadow {
            color: "#888888"
            radius: 10
            samples: 16
            verticalOffset: 2
            horizontalOffset: 2
        }
    }

    // Main content section: Buttons for Camera and Lane Assist (No background color, only border)
    Rectangle {
        width: parent.width * 0.5  // Make it dynamic and smaller
        height: 200
        radius: 20
        color: "transparent"  // No background color
        border.color: "#444"
        border.width: 2
        anchors.centerIn: parent

        // Layout to align the buttons in a row with proper spacing
        RowLayout {
            anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 120  // Increased spacing between the buttons

            // Camera Button
            Item {
                width: 120  // Adjusted size for camera button
                height: 120
                Layout.preferredWidth: 100
                Layout.preferredHeight: 120

                // Camera Icon and Text inside a Column
                Column {
                    anchors.centerIn: parent
                    spacing: 10

                    Image {
                        source: "qrc:/images/camera.png"
                        width: 120  // Larger icon size
                        height: 120
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Camera"
                        font.pixelSize: 18
                        color: "#111111"
                        anchors.horizontalCenter: parent.horizontalCenter

                        layer.enabled: true
                        layer.effect: DropShadow {
                            color: "#888888"
                            radius: 7
                            samples: 14
                            verticalOffset: 2
                            horizontalOffset: 2
                        }
                    }
                }
            }

            // Lane Assist Button
            Item {
                width: 120  // Adjusted size for lane assist button
                height: 120
                Layout.preferredWidth: 100
                Layout.preferredHeight: 120

                // Lane Assist Icon and Text inside a Column
                Column {
                    anchors.centerIn: parent
                    spacing: 10

                    Image {
                        source: "qrc:/images/lane.png"
                        width: 120  // Larger icon size
                        height: 120
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Lane Assist"
                        font.pixelSize: 18
                        color: "#111111"
                        anchors.horizontalCenter: parent.horizontalCenter

                        layer.enabled: true
                        layer.effect: DropShadow {
                            color: "#888888"
                            radius: 7
                            samples: 14
                            verticalOffset: 2
                            horizontalOffset: 2
                        }
                    }
                }
            }
        }
    }
}
