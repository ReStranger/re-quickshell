import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland
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
        WlrLayershell.namespace: "quickshell:quicksettings"
        anchors {
            top: true
            right: true
            bottom: true
        }

        function hide() {
            GlobalStates.qsOpen = false;
        }
        readonly property real windowWidth: container.implicitWidth + container.spacing * 2 + Theme.size.hyprlandGapsOut + 50
        readonly property real windowHeight: container.height + 4 * container.spacing + Theme.size.hyprlandGapsOut * 2
        property bool menuOpen: false

        implicitWidth: windowWidth
        implicitHeight: windowHeight + Theme.size.barHeight

        mask: Region {
            item: background
        }
        // WindowShadow {
        //     target: background
        // }
        Rectangle {
            id: background
            focus: true
            clip: true
            readonly property real targetY: GlobalStates.qsOpen ? (Config.options.bar.cornerStyle == 1 ? Theme.size.barHeight : Theme.size.barHeight + Theme.size.hyprlandGapsOut) : -root.windowHeight
            y: targetY

            anchors {
                left: parent.left
                right: parent.right
                rightMargin: Theme.size.hyprlandGapsOut
                leftMargin: 50
            }

            Behavior on y {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            height: container.height + 2 * container.spacing
            color: Config.options.theme.showBackground ? Theme.color.bg00 : "transparent"
            radius: Theme.rounding.windowRounding

            border {
                width: 1
                color: Theme.color.border00
            }

            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape) {
                    root.hide();
                }
            }

            ColumnLayout {
                id: container
                spacing: 7.5

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    margins: container.spacing
                }

                RowLayout {
                    spacing: 7.5
                    Layout.alignment: Qt.AlignTop
                    Layout.margins: 7.5
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
                            font.pixelSize: 16
                            text: Config.options.system.user.name !== "" ? Config.options.system.user.name : SystemInfo.username
                            font.weight: Font.Bold
                        }
                        StyledText {
                            font.pixelSize: 12
                            text: DateTime.uptime
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }

                    StyledButton {
                        iconSize: 20
                        icon.name: "settings"
                        provider: StyledButton.IconProvider.Material
                    }
                    StyledButton {
                        iconSize: 20
                        icon.name: "restart_alt"
                        provider: StyledButton.IconProvider.Material
                    }
                    StyledButton {
                        iconSize: 20
                        icon.name: "power_settings_new"
                        provider: StyledButton.IconProvider.Material
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 1
                    color: Theme.color.border00
                }
                GridLayout {
                    id: qsButtonGrid
                    columns: 2
                    QSNetworkButton {
                        onIsToggleOpenChanged: root.menuOpen = isToggleOpen
                    }
                    QSBluetoothButton {}
                    QSPowerProfileButton {}
                    QSDnd {}
                }
                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 1
                    color: Theme.color.border00
                }
                ColumnLayout {
                    id: qsSliderColumn
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    RowLayout {
                        Layout.fillWidth: true
                        ThinText {
                            Layout.fillWidth: true
                            text: "Brightness"
                            font.weight: 100
                            color: ColorUtils.transparentize(Theme.color.fg, 0.4)
                        }
                        ThinText {
                            text: Utils.normalizedToPercent(Brightness.value) + "%"
                            font.weight: 100
                            color: ColorUtils.transparentize(Theme.color.fg, 0.4)
                        }
                    }
                    RowLayout {
                        // visible: Brightness.initialized
                        spacing: 0
                        MaterialSymbol {
                            icon: Brightness.materialSymbol
                            font.pixelSize: 22
                            color: Theme.color.fg
                            Layout.alignment: Qt.AlignVCenter
                        }
                        StyledSlider {
                            value: Brightness.value
                            from: 0
                            to: 1
                            stepSize: 0.05
                            onMoved: Brightness.set(value)
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        ThinText {
                            Layout.fillWidth: true
                            text: "Volume"
                        }
                        ThinText {
                            text: Utils.normalizedToPercent(Audio.sink.volume) + "%"
                            font.weight: 100
                            color: ColorUtils.transparentize(Theme.color.fg, 0.4)
                        }
                    }
                    RowLayout {
                        spacing: 0
                        MaterialSymbol {
                            icon: Audio.sink.materialSymbol
                            font.pixelSize: 22
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

        Behavior on height {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCubic
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
}
