import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.config

Slider {
    id: root
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignVCenter

    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 12
        width: root.availableWidth
        height: implicitHeight
        radius: 100
        color: Theme.color.sf01
        border.color: Theme.color.bg01

        Rectangle {
            width: root.visualPosition * (parent.width - 12) + 10
            height: parent.height
            color: Theme.color.primary
            radius: 100
        }
    }

    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 12
        implicitHeight: 12
        radius: 100
        color: root.pressed ? Theme.color.fg : Theme.color.primary
    }
}
