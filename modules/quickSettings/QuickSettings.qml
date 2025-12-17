import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import Quickshell
import Quickshell.Hyprland
import qs.components
import qs.services
import qs.utils
import qs.config

Scope {
    PanelWindow {
        id: root
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
        readonly property real barMargin: Theme.size.barHeight + Theme.size.hyprlandGapsOut
        readonly property real openedHeight: container.height + 4 * container.spacing

        implicitWidth: container.implicitWidth + container.spacing * 2 + Theme.size.hyprlandGapsOut
        implicitHeight: background.height > 0 ? openedHeight : 0

        visible: background.height > 0

        mask: Region {
            item: background
        }

        Rectangle {
            id: background
            focus: true
            clip: true

            anchors {
                top: !Config.options.bar.bottom ? parent.top : undefined
                left: parent.left
                right: parent.right
                bottom: Config.options.bar.bottom ? parent.bottom : undefined
                topMargin: root.barMargin
                bottomMargin: root.barMargin
                rightMargin: Theme.size.hyprlandGapsOut
            }

            height: GlobalStates.qsOpen ? container.height + 2 * container.spacing : 0
            color: Config.options.theme.showBackground ? Theme.color.bg00 : ColorUtils.transparentize(Theme.color.bg00, 0.89)
            radius: Theme.rounding.windowRounding

            onHeightChanged: if (height <= 0)
                root.hide()

            border {
                width: 1
                color: Theme.color.border00
            }

            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape) {
                    root.hide();
                }
            }

            Behavior on height {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

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
                    Layout.margins: Theme.rounding.windowRounding / 2
                    Layout.bottomMargin: 0

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
                            fontSize: 16
                            text: Config.options.system.user.name !== "" ? Config.options.system.user.name : SystemInfo.username
                            font.weight: Font.Bold
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
                        QSNetworkButton {}
                        QSBluetoothButton {}
                        QSPowerProfileButton {}
                        QSDnd {}
                    }
                }
                Rectangle {
                    color: Config.options.theme.showBackground ? Theme.color.bg01 : ColorUtils.transparentize(Theme.color.fg, 0.89)
                    implicitWidth: qsSliderColumn.implicitWidth + 10
                    implicitHeight: qsSliderColumn.implicitHeight + 10
                    radius: Theme.rounding.windowRounding
                    Layout.fillWidth: true
                    ColumnLayout {
                        id: qsSliderColumn
                        anchors {
                            fill: parent
                            margins: 5
                        }
                        Layout.fillWidth: true
                        RowLayout {
                            spacing: 0
                            MaterialSymbol {
                                icon: Audio.sink.materialSymbol
                                iconSize: 22
                                color: Theme.color.fg
                                Layout.alignment: Qt.AlignVCenter
                            }
                            StyledSlider {
                                value: Audio.sink.volume
                                from: 0
                                to: 1
                                stepSize: 0.05
                                onMoved: Audio.sink.setVolume(value)
                            }
                        }
                    }
                }
            }
        }

        HyprlandFocusGrab {
            id: grab
            windows: [root]
            active: GlobalStates.qsOpen
            onCleared: () => {
                if (!active)
                    root.hide();
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
