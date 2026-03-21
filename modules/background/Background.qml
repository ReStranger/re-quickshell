import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.components
import qs.config

Variants {
    id: root
    model: Quickshell.screens

    PanelWindow {
        id: bgRoot

        required property var modelData
        WlrLayershell.layer: WlrLayer.Bottom
        WlrLayershell.namespace: "quickshell:background"
        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }
        Item {
            anchors.fill: parent
            clip: true
            StyledImage {
                anchors.fill: parent
                source: Config.options.background.wallpaperPath
                fillMode: Image.PreserveAspectCrop
            }
        }
    }
}
