import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.components
import qs.services
import qs.config

Scope {
    PanelWindow {
        id: root
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "quickshell:datemenu"
        anchors.top: true

        readonly property int sideMargin: 50
        readonly property int contentPadding: 5

        function hide() {
            GlobalStates.dateMenuOpen = false;
        }

        readonly property real windowWidth: container.implicitWidth + container.spacing * 2 + 100
        readonly property real windowHeight: container.height + 2 * container.spacing + Theme.size.hyprlandGapsOut * 2

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
            readonly property real openY: Config.options.bar.cornerStyle == 1
                                        ? Theme.size.barHeight
                                        : Theme.size.barHeight + Theme.size.hyprlandGapsOut
            readonly property real closedY: -root.windowHeight
            y: GlobalStates.dateMenuOpen ? openY : closedY

            anchors {
                left: parent.left
                right: parent.right
                leftMargin: root.sideMargin
                rightMargin: root.sideMargin
            }

            Behavior on y {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            height: container.height + 2 * container.spacing
            color: Theme.color.bg00
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

            RowLayout {
                id: container
                spacing: 15

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    margins: spacing
                }

                Rectangle {
                    id: notificationsPane
                    implicitWidth: 310
                    implicitHeight: container.height + 2 * container.spacing - 30
                    color: Theme.color.sf00
                    radius: Theme.rounding.windowRounding

                    ScrollView {
                        clip: true
                        anchors.fill: parent
                        padding: root.contentPadding

                        ListView {
                            spacing: 0
                            boundsBehavior: Flickable.StopAtBounds
                            model: ScriptModel {
                                values: NotificationDaemon.data.slice().reverse()
                            }

                            delegate: NotificationRow {}
                        }
                    }
                }

                ColumnLayout {
                    id: actionsColumn
                    StyledButton {
                        implicitWidth: 80
                        implicitHeight: 80
                        text: "left"
                        onClicked: Quickshell.execDetached(["sh", "-c", "notify-send \"Заголовок\" \"Основной текст\""])
                    }
                    StyledButton {
                        implicitWidth: 80
                        implicitHeight: 80
                        text: "left"
                        onClicked: Quickshell.execDetached(["sh", "-c", "notify-send \"Заголовок\" \"Основной текст\" --action=\"key1=Кнопка 1\" --action=\"key2=Кнопка 2\""])
                    }
                    StyledButton {
                        implicitWidth: 80
                        implicitHeight: 80
                        text: "left"
                    }
                    StyledButton {
                        implicitWidth: 80
                        implicitHeight: 80
                        text: "left"
                    }
                }
            }
        }

        HyprlandFocusGrab {
            id: grab
            windows: [root]
            active: GlobalStates.dateMenuOpen
            onCleared: () => {
                if (!active)
                    root.hide();
            }
        }
    }
}
