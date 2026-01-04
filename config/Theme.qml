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
        property color bg00: root.palette.primaryBg
        property color bg01: root.palette.secondaryBg
        property color sf00: root.palette.surfacePrimaryBg
        property color sf01: root.palette.surfaceSecondaryBg
        property color sf02: root.palette.surfaceThirdBg
        property color fg: root.palette.foreground
        property color primary: root.palette.primary
        property color green: root.palette.green
        property color blue: root.palette.blue
        property color orange: root.palette.orange
        property color red: root.palette.red
        property color border00: ColorUtils.transparentize(sf01, 60 / 100)
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
        property real barIcon: 20
        property real padding: 7.5
    }
}
