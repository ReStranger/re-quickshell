pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Widgets
import qs.config

StyledButton {
    id: root
    property real iconSize: 22
    property string iconName: "search"
    property string iconColor: Theme.color.fg
    property bool material: true

    contentItem: Item {
        anchors.centerIn: parent
        implicitWidth: icon.iconSize + 2
        implicitHeight: icon.iconSize + 2

        MaterialSymbol {
            id: icon
            visible: root.material
            anchors.centerIn: parent
            font.pixelSize: root.iconSize
            icon: root.iconName
            color: root.enabled ? (root.pressed ? Theme.color.bg00 : root.iconColor) : Theme.color.sf01
        }
        IconImage {
            id: image
            visible: !root.material
            anchors.centerIn: parent
            source: `image://icon/${root.iconName}`
            width: root.iconSize
            height: root.iconSize
            mipmap: true
        }
    }
}
