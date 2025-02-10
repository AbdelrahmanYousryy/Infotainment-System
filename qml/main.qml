import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12

ApplicationWindow {
    visible: true
    width: 1280
    height: 720
    title: "Infotainment System"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainScreen  // ✅ Start with the main menu
    }

    // ✅ Function to Open GPS Screen
    function openGPS() {
        console.log("GPS Button Clicked!");
        stackView.push(Qt.createComponent("GPSView.qml"));  // ✅ Dynamically load GPSView
    }
    function openMedia() {
        console.log("Media Player Opened!");
        stackView.push(Qt.createComponent("MediaPlayer.qml"));
    }
    function openAssist() {
        console.log("Assistance Screen Opened!");
        stackView.push(Qt.createComponent("assist.qml"));
    }


    Component {
        id: mainScreen
        Rectangle {
            anchors.fill: parent

            // 🔹 Background Image
            Image {
                source: "qrc:/images/background.jpg"
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
            }

            // 🔹 Date & Time in the Top-Left
            Text {
                id: dateTime
                text: Qt.formatDateTime(new Date(), "dddd, dd MMM yyyy - hh:mm AP")
                font.pixelSize: 24
                font.family: "Roboto"
                color: "#111111"
                horizontalAlignment: Text.AlignHCenter
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 20

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#888888"
                    radius: 7
                    samples: 14
                    verticalOffset: 2
                    horizontalOffset: 2
                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: dateTime.text = Qt.formatDateTime(new Date(), "dddd, dd MMM yyyy - hh:mm AP")
                }
            }

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 40
                spacing: 20

                Image {
                    source: "qrc:/images/logo.png"
                    width: 220
                    height: 220
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle {
                    width: 1050
                    height: 320
                    radius: 30
                    color: Qt.rgba(1, 1, 1, 0.3)
                    border.color: "#AAAAAA"
                    border.width: 3
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 20

                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 60

                        Repeater {
                            model: [
                                { "name": "GPS", "icon": "qrc:/images/gps.png", "action": "openGPS" },
                                { "name": "Media", "icon": "qrc:/images/media.png", "action":"openMedia" },
                                { "name": "Assist", "icon": "qrc:/images/assist.png","action":"openAssist" },
                                { "name": "Settings", "icon": "qrc:/images/settings.png" }
                            ]

                            delegate: Item {
                                width: 190
                                height: 230

                                Column {
                                    width: parent.width
                                    spacing: 12
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Image {
                                        source: modelData.icon
                                        width: 140
                                        height: 140
                                        fillMode: Image.PreserveAspectFit
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }

                                    Text {
                                        text: modelData.name
                                        font.pixelSize: 28
                                        font.bold: true
                                        font.family: "Roboto"
                                        color: "#111111"
                                        horizontalAlignment: Text.AlignHCenter
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

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        console.log(modelData.name + " Clicked");

                                        if (modelData.action === "openGPS") {
                                            openGPS();
                                        }else if (modelData.action === "openMedia")
                                        {
                                            openMedia();

                                        }else if (modelData.action === "openAssist")
                                        {
                                            openAssist();

                                        }else {
                                            console.log("No function assigned to " + modelData.name);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
