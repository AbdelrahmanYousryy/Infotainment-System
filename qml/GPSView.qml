import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtLocation 5.12
import QtPositioning 5.12

Item {
    id: gpsView
    anchors.fill: parent

    // 🔹 Back Button
    MouseArea {
        id: backButton
        width: 50
        height: 50
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
        z: 2  // ✅ Ensure it stays above the map
        onClicked: stackView.pop();  // ✅ Navigate back

        Image {
            id: backIcon
            source: "qrc:/images/back.png"
            width: 40
            height: 40
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
            z: 2
        }
    }

    // 🔹 Embedded Map
    Map {
        id: map
        anchors.fill: parent
        anchors.topMargin: 0
        z: 1  // ✅ Keeps it below the back button

        plugin: Plugin {
            name: "osm"
        }

        center: QtPositioning.coordinate(29.976480, 31.131302)  // ✅ Giza, Cairo (Great Pyramid Area)
        zoomLevel: 15
    }
}
