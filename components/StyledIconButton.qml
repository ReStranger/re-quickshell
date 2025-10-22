pragma ComponentBehavior: Bound

import QtQuick
import qs.config

StyledButton {
    id: root
    property real iconSize: 22
    property string iconName: "search"
    property string iconColor: Theme.color.fg

    contentItem: Item {
        anchors.centerIn: parent
        implicitWidth: icon.font.pixelSize + 2
        implicitHeight: icon.font.pixelSize + 2

        MaterialSymbol {
            id: icon
            anchors.centerIn: parent
            font.pixelSize: root.iconSize
            icon: root.iconName
            color: root.enabled ? (root.pressed ? Theme.color.bg00 : root.iconColor) : Theme.color.sf01
        }
    }
}
