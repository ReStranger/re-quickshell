import QtQuick
import qs.utils
import qs.config

MouseArea {
    id: root
    clip: true
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    property bool toggled: false
    property alias contentItem: contentLoader.sourceComponent

    property color disabledColor: Theme.color.bg00
    property color defaultColor: ColorUtils.transparentize(Theme.color.fg, 0.94)
    property color hoveredColor: ColorUtils.transparentize(Theme.color.fg, 0.8)
    property color pressedColor: Theme.color.primary
    property real radius: Theme.rounding.windowRounding / 1.2
    property bool changeColors: true

    function determineColor(): color {
        if (root.pressed || root.toggled) {
            return root.pressedColor;
        }
        if (root.containsMouse) {
            return root.hoveredColor;
        }
        return root.defaultColor;
    }

    implicitWidth: contentLoader.item ? contentLoader.item.implicitWidth + 10 : 0
    implicitHeight: contentLoader.item ? contentLoader.item.implicitHeight + 8 : 0

    Loader {
        id: backgroundLoader
        active: !Config.options.theme.flatButton
        anchors.fill: parent
        Rectangle {
            visible: !Config.options.theme.flatButton
            anchors.fill: parent
            radius: root.radius
            color: root.enabled ? root.determineColor() : root.disabledColor
            border {
                color: ColorUtils.transparentize("#eeeeee", 0.90)
                width: 1
            }
            Behavior on color {
                ColorAnimation {
                    duration: 100
                    easing.type: Easing.Linear
                }
            }
        }
    }

    Loader {
        id: contentLoader
        anchors.centerIn: parent
    }
}
