import QtQuick
import Quickshell.Widgets

IconImage {
    id: root
    property string icon: "nix-snowflake"

    implicitSize: 16
    source: `image://icon/${root.icon}`
    mipmap: true
}
