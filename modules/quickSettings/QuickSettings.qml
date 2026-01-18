import QtQuick
import QtQuick.Controls
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
        readonly property real windowWidth: container.implicitWidth + container.spacing * 2 + Theme.size.hyprlandGapsOut + 50
        readonly property real windowHeight: container.height + 4 * container.spacing + Theme.size.hyprlandGapsOut * 2

        implicitWidth: windowWidth
        implicitHeight: windowHeight + Theme.size.barHeight

        mask: Region {
            item: background
        }
        WindowShadow {
            sourceComponent: background
        }
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
            color: Config.options.theme.showBackground ? Theme.color.bg00 : ColorUtils.transparentize(Theme.color.bg00, 0.89)
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
                    ScrollView {
                        Column {

                        }

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
                        RowLayout {
                            visible: Brightness.initialized
                            y: Brightness.initialized ? -width : 0
                            spacing: 0
                            MaterialSymbol {
                                icon: Brightness.materialSymbol
                                iconSize: 22
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
                        Behavior on width {
                            NumberAnimation {
                                duration: 250
                                easing.type: Easing.OutCubic
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
}
