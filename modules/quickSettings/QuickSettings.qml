import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import Quickshell
import Quickshell.Hyprland
import qs.components
import qs.services
import qs.config

Scope {
    id: root
    PanelWindow {
        id: qsRoot
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        anchors {
            top: true
            right: true
            bottom: true
        }

        function hide() {
            GlobalStates.qsOpen = false;
        }
        readonly property real topMargin: Theme.size.barHeight + Theme.size.hyprlandGapsOut
        readonly property real openedHeight: container.height + 4 * container.spacing

        implicitWidth: container.implicitWidth + container.spacing * 2 + Theme.size.hyprlandGapsOut
        implicitHeight: shape.height > 0 ? openedHeight : 0

        visible: shape.height > 0

        mask: Region {
            item: shape
        }

        Shape {
            id: shape
            focus: true

            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape) {
                    qsRoot.hide();
                }
            }

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: qsRoot.topMargin
                rightMargin: Theme.size.hyprlandGapsOut
            }
            height: GlobalStates.qsOpen ? container.height + 2 * container.spacing : 0
            onHeightChanged: if (height <= 0)
                qsRoot.hide()

            Rectangle {
                id: background
                color: Config.options.theme.showBackground ? Theme.color.bg00 : ColorUtils.transparentize(Theme.color.bg00, 0.89)
                width: shape.width
                height: shape.height
                radius: Theme.rounding.windowRounding
                border {
                    width: 1
                    color: Theme.color.border00
                }
            }
            Behavior on height {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            layer.enabled: true
            layer.samples: 4

            ColumnLayout {
                id: container
                spacing: Theme.rounding.windowRounding / 2

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    margins: container.spacing
                }

                RowLayout {
                    spacing: Theme.rounding.windowRounding / 2
                    Layout.alignment: Qt.AlignTop

                    Rectangle {
                        clip: true
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                        radius: 100
                        border {
                            width: 1
                            color: Theme.color.border00
                        }

                        Image {
                            width: 50
                            height: 50
                            anchors.fill: parent
                            source: Directories.avatarPath
                            fillMode: Image.PreserveAspectCrop
                            layer.enabled: true
                            layer.effect: OpacityMask {
                                maskSource: Rectangle {
                                    width: 50
                                    height: 50
                                    radius: 100
                                }
                            }
                        }
                    }
                    ColumnLayout {
                        StyledText {
                            fontSize: 12
                            text: DateTime.uptime
                        }
                        StyledText {
                            fontSize: 12
                            text: DateTime.uptime
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }

                    StyledIconButton {
                        iconSize: 20
                        iconName: "settings"
                        enabled: false
                    }

                    StyledIconButton {
                        iconSize: 20
                        iconName: "restart_alt"
                    }

                    StyledIconButton {
                        iconSize: 20
                        iconName: "power_settings_new"
                    }
                }
                Rectangle {
                    color: Config.options.theme.showBackground ? Theme.color.bg01 : ColorUtils.transparentize(Theme.color.fg, 0.89)
                    implicitWidth: qsButtonGrid.implicitWidth + 10
                    implicitHeight: qsButtonGrid.implicitHeight + 10
                    radius: Theme.rounding.windowRounding
                    border {
                        width: 1
                        color: Theme.color.border00
                    }
                    GridLayout {
                        id: qsButtonGrid
                        anchors {
                            top: parent.top
                            left: parent.left
                            margins: 5
                        }
                        columns: 2
                    }
                }
            }
        }

        HyprlandFocusGrab {
            id: grab
            windows: [qsRoot]
            active: GlobalStates.qsOpen
            onCleared: () => {
                if (!active)
                    qsRoot.hide();
            }
        }
    }

    IpcHandler {
        target: "QuickSettings"

        function toggle(): void {
            GlobalStates.qsOpen = !GlobalStates.qsOpen;
        }

        function close(): void {
            GlobalStates.qsOpen = false;
        }

        function open(): void {
            GlobalStates.qsOpen = true;
        }
    }
}
