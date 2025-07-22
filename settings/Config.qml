import QtQuick
import Quickshell

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root
    property QtObject color
    property QtObject rounding
    property QtObject font
    property QtObject size

    color: QtObject {
        property color bg00: "#121214"
        property color bg01: "#212126"
        property color sf00: "#2a2a30"
        property color sf01: "#373740"
        property color sf02: "#676778"
        property color fg: "#e9ecf2"
        property color primary: "#f17ac6"
    }
    rounding: QtObject {
        property int screenRounding: 15
    }
    font: QtObject {
        property QtObject family: QtObject {
            property string main: "Rubik"
            property string iconNerd: "SpaceMono NF"
            property string monospace: "JetBrains Mono NF"
        }
        property QtObject pixelSize: QtObject {
            property int normal: 16
        }
    }
    size: QtObject {
        property real barHeight: 35
        property real hyprlandGapsOut: 10
        property real barIcon: 20
    }
}
