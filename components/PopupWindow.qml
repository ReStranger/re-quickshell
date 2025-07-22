import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.settings

Scope {
    id: root

    default property alias content: content.data
    property alias anchors: popupWindow.anchors
    property bool isVisible: false
    property var toggleFunction
    property int width
    property int height
    property bool animOnWidth: false
    property bool animOnHeight: false

    PanelWindow {
        id: popupWindow

        visible: root.isVisible

        function hide() {
            root.isVisible = false;
        }
        exclusiveZone: 0
        implicitWidth: root.isVisible ? root.width + Config.size.hyprlandGapsOut * 2 : 0
        implicitHeight: root.isVisible ? root.height + Config.size.hyprlandGapsOut * 2 : 0

        color: "transparent"
        mask: Region {
            item: background
        }
        Rectangle {
            id: background

            anchors {
                top: popupWindow.anchors.top === true ? parent.top : undefined
                left: popupWindow.anchors.left === true ? parent.left : undefined
                right: popupWindow.anchors.right === true ? parent.right : undefined
                bottom: popupWindow.anchors.bottom === true ? parent.bottom : undefined
                topMargin: Config.size.hyprlandGapsOut
                leftMargin: Config.size.hyprlandGapsOut
                rightMargin: Config.size.hyprlandGapsOut
                bottomMargin: Config.size.hyprlandGapsOut
            }
            radius: Config.rounding.screenRounding

            width: parent.width - Config.size.hyprlandGapsOut * 2
            height: parent.height - Config.size.hyprlandGapsOut * 2
            clip: true
            color: Config.color.bg00

            border {
                width: 1
                color: Config.color.sf01
            }
            Behavior on width {
                enabled: root.animOnWidth
                NumberAnimation {
                    duration: 500
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: [0.38, 1.21, 0.22, 1.00, 1, 1]
                }
            }
            Behavior on height {
                enabled: root.animOnHeight
                NumberAnimation {
                    duration: 500
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: [0.38, 1.21, 0.22, 1.00, 1, 1]
                }
            }
            Item {
                id: content
                anchors.fill: parent
            }
        }
        HyprlandFocusGrab {
            id: grab
            windows: [popupWindow]
            active: root.isVisible
            onCleared: () => {
                if (!active)
                    root.toggleFunction();
            }
        }
    }
}
