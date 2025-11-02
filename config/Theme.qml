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

    color: QtObject {
        // property color bg00: root.transparentize("#121214", Config.options.theme.blur / 100)
        property color bg00: "#121214"
        property color bg01: "#212126"
        property color sf00: "#2a2a30"
        property color sf01: "#373740"
        property color sf02: "#676778"
        property color fg: "#e9ecf2"
        property color primary: "#f17ac6"
        property color green: "#55b682"
        property color blue: "#7aaaff"
        property color orange: "#ff9c6a"
        property color red: "#f25c5c"
        // property color border00: root.transparentize("#eeeeee", 96 / 100)
        property color border00: ColorUtils.transparentize(sf01, 60 / 100)
        property color shadow: Qt.rgba(0, 0, 0, 0.4)
    }
    rounding: QtObject {
        property int windowRounding: 15
        property int screenRounding: windowRounding + root.size.hyprlandGapsOut / 2
    }
    font: QtObject {
        property QtObject family: QtObject {
            property string main: "Rubik"
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
    }
}
