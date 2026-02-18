import QtQuick
import Quickshell.Widgets

IconImage {
    id: root
    property string icon: "nix-snowflake"
    property string rawSource: `image://icon/${root.icon}`

    implicitSize: 16
    source: root.rawSource
    mipmap: true
}
