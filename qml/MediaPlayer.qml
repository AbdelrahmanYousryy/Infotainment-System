import QtQuick 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import QtGraphicalEffects 1.12

Item {
    id: mediaPlayer
    anchors.fill: parent

    // 🔹 Background Image (Same as Main UI)
    Image {
        source: "qrc:/images/background.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    // 🔹 Back Button
    MouseArea {
        width: 50
        height: 50
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
        onClicked: stackView.pop();

        Image {
            source: "qrc:/images/back.png"
            width: 40
            height: 40
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
        }
    }

    // 🔹 Title ("Media Player" - Dark Like Main UI)
    Text {
        text: "🎵 Media Player"
        font.pixelSize: 28
        font.bold: true
        font.family: "Roboto"
        color: "#111111"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 30

        layer.enabled: true
        layer.effect: DropShadow {
            color: "#888888"
            radius: 8
            samples: 16
            verticalOffset: 2
            horizontalOffset: 2
        }
    }

    // 🔹 Song List (ONLY DARKER BORDERS, NO BACKGROUND)
    ListView {
        id: songListView
        width: parent.width * 0.8
        height: parent.height * 0.5
        clip: true
        spacing: 15
        model: mediaBackend.getSongs()
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 80

        delegate: Rectangle {
            width: parent.width
            height: 60
            color: "transparent"  // ✅ No background, only border remains
            radius: 10
            border.color: "#222222"  // ✅ Darker border
            border.width: 3  // ✅ Slightly thicker for better visibility

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Playing: " + modelData);
                    mediaBackend.playMedia(modelData);
                }
            }

            Text {
                text: modelData
                color: "#111111"  // ✅ Dark text matching main UI
                font.pixelSize: 22
                font.bold: true
                anchors.centerIn: parent

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#555555"  // ✅ Subtle shadow for depth
                    radius: 8
                    samples: 16
                    verticalOffset: 1
                    horizontalOffset: 1
                }
            }
        }

        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AlwaysOn
        }
    }

    // 🔹 Play & Pause Controls (Lowered Below the Song List)
    Row {
        anchors.top: songListView.bottom  // ✅ Positioned below the song list
        anchors.topMargin: 50  // ✅ Added margin to avoid overlap
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 100  // ✅ Adjusted spacing for balance

        // 🔹 Pause Button
        Column {
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                width: 100  // ✅ Bigger button
                height: 100
                onClicked: mediaBackend.pauseMedia()

                Image {
                    source: "qrc:/images/pause.png"
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Text {
                text: "Pause"
                font.pixelSize: 24  // ✅ Slightly bigger text
                font.bold: true
                font.family: "Roboto"
                color: "#111111"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#888888"
                    radius: 8
                    samples: 16
                    verticalOffset: 1
                    horizontalOffset: 1
                }
            }
        }

        // 🔹 Play Button
        Column {
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                width: 100
                height: 100
                onClicked: {
                    if (songListView.currentIndex !== -1) {
                        mediaBackend.resumeMedia();  // ✅ Call registered QML function
                    } else {
                        console.log("Error: No song selected!");
                    }
                }

                Image {
                    source: "qrc:/images/play.png"
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Text {
                text: "Play"
                font.pixelSize: 24  // ✅ Slightly bigger text
                font.bold: true
                font.family: "Roboto"
                color: "#111111"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#888888"
                    radius: 8
                    samples: 16
                    verticalOffset: 1
                    horizontalOffset: 1
                }
            }
        }
    }
}
