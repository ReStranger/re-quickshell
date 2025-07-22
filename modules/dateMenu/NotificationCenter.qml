import QtQuick
import Quickshell
import qs.components

Scope {
    id: root
    Rectangle {
        anchors.fill: parent
        implicitWidth: 100
        implicitHeight: 100
        color: "red"
        Notification {}
    }
}
