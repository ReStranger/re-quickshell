import QtQuick
import qs.utils
import qs.config

MouseArea {
    id: root
    clip: true
    hoverEnabled: true

    property alias contentItem: contentLoader.sourceComponent

    property color disabledColor: Theme.color.bg00
    property color defaultColor: ColorUtils.transparentize(Theme.color.fg, 94 / 100)
    property color hoveredColor: Theme.color.sf00
    property color pressedColor: Theme.color.primary
    property bool changeColors: true

    function determineColor(): color {
        if (root.pressed) {
            return root.pressedColor;
        }
        if (root.hovered) {
            return root.hoveredColor;
        }
        return root.defaultColor;
    }

    implicitWidth: contentLoader.item ? contentLoader.item.implicitWidth + 10 : 0
    implicitHeight: contentLoader.item ? contentLoader.item.implicitHeight + 8 : 0

    ShadowButton {
        anchors.fill: parent
        radius: Theme.rounding.windowRounding / 1.2
        fillColor: root.enabled ? root.determineColor() : root.disabledColor
        borderColor: ColorUtils.transparentize("#eeeeee", 94 / 100)
        borderWidth: 1
        Behavior on fillColor {
            ColorAnimation {
                duration: 100
                easing.type: Easing.Linear
            }
        }
    }

    Loader {
        id: contentLoader
        anchors.centerIn: parent
    }
}
