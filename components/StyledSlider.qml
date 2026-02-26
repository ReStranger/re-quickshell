import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.config
import qs.utils

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
        radius: Theme.rounding.windowRounding
        color: Theme.color.bg01
        border.color: ColorUtils.transparentize("#eeeeee", 0.90)

        Rectangle {
            width: root.visualPosition * (parent.width - 12) + 10
            height: parent.height
            color: Theme.color.primary
            radius: Theme.rounding.windowRounding
            border.color: ColorUtils.transparentize("#eeeeee", 0.90)
        }
    }

    handle: Item {
        id: handle
        implicitWidth: 14
        implicitHeight: 14

        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2

        Rectangle {
            id: normal
            anchors.centerIn: parent
            width: 25
            height: 16
            radius: Theme.rounding.windowRounding / 2
            color: Theme.color.fg
            border.color: Theme.color.border00
        }
    }
}
