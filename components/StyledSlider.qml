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

    handle: Item {
        id: handle
        implicitWidth: 14
        implicitHeight: 14

        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2

        Rectangle {
            id: normal
            anchors.centerIn: parent
            width: 14
            height: 14
            radius: Theme.rounding.windowRounding / 2
            color: Theme.color.primary
            visible: !root.pressed
        }

        Item {
            id: pressedFx
            anchors.centerIn: parent
            width: 16
            height: 16
            visible: root.pressed
            opacity: root.pressed ? 1 : 0

            Rectangle {
                anchors.fill: parent
                radius: width / 2
                color: Theme.color.primary
            }

            Rectangle {
                anchors.centerIn: parent
                width: parent.width * 0.70
                height: width
                radius: width / 2
                color: "transparent"
                border.width: parent.width * 0.10
                border.color: ColorUtils.transparentize(Theme.color.sf01, 0.4)
            }

            Rectangle {
                anchors.centerIn: parent
                width: parent.width * 0.08
                height: width
                radius: width / 2
                border.color: ColorUtils.transparentize(Theme.color.sf01, 0.4)
            }

            Behavior on scale {
                NumberAnimation {
                    duration: 120
                }
            }
            scale: root.pressed ? 1.0 : 0.85
        }
    }
}
