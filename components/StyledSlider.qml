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
        implicitHeight: 14
        width: root.availableWidth
        height: implicitHeight
        radius: Theme.rounding.windowRounding
        color: Theme.color.sf01
        border.color: Theme.color.bg01

        Rectangle {
            width: root.visualPosition * (parent.width - 12) + 10
            height: parent.height
            color: Theme.color.primary
            radius: Theme.rounding.windowRounding
        }
    }

    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 14
        implicitHeight: 14
        radius: Theme.rounding.windowRounding / 2
        color: root.pressed ? Theme.color.fg : Theme.color.primary
    }
}
