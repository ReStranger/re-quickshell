pragma Singleton

import QtQuick
import Quickshell
import qs.utils

Singleton {
    id: root

    property QtObject color
    property QtObject rounding
    property QtObject font
    property QtObject size

    readonly property var palette: (Config.options.theme.darkmode ? Config.options.theme.darkColor : (Config.options.theme.lightColor || Config.options.theme.darkColor))

    color: QtObject {
        property color bg00: ColorUtils.transparentize(root.palette.primaryBg, Config.options.theme.blur)
        property color bg01: ColorUtils.transparentize(root.palette.secondaryBg, Config.options.theme.blur)
        property color sf00: ColorUtils.transparentize(root.palette.surfacePrimaryBg, Config.options.theme.blur)
        property color sf01: ColorUtils.transparentize(root.palette.surfaceSecondaryBg, Config.options.theme.blur)
        property color sf02: ColorUtils.transparentize(root.palette.surfaceThirdBg, Config.options.theme.blur)
        property color fg: root.palette.foreground
        property color primary: root.palette.primary
        property color green: root.palette.green
        property color blue: root.palette.blue
        property color orange: root.palette.orange
        property color red: root.palette.red
        property color border00: ColorUtils.transparentize("#5E5C5B", 0.2)
        property color shadow: Qt.rgba(0, 0, 0, 0.4)
    }
    rounding: QtObject {
        property int windowRounding: Config.options.theme.rounding
        property int screenRounding: windowRounding + root.size.hyprlandGapsOut / 2
    }
    font: QtObject {
        property QtObject family: QtObject {
            property string main: "Ubuntu Nerd Font"
            property string iconNerd: "SpaceMono NF"
            property string monospace: "JetBrains Mono NF"
        }
        property QtObject pixelSize: QtObject {
            property int small: 15
            property int normal: 16
        }
    }
    size: QtObject {
        property real baseBarHeight: 40
        property real barHeight: Config.options.bar.cornerStyle === 1 ? (baseBarHeight + root.size.hyprlandGapsOut * 2) : baseBarHeight
        property real hyprlandGapsOut: 10
        property real notification: 300
        property real barIcon: 20
        property real padding: 7.5
    }
}
