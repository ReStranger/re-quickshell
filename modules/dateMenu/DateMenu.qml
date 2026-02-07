import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.components
import qs.services
import qs.config

Scope {
    PanelWindow {
        id: root
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        anchors.top: true

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
        WindowShadow {
            sourceComponent: background
        }

        Rectangle {
            id: background
            focus: true
            clip: true
            readonly property real targetY: GlobalStates.dateMenuOpen ? (Config.options.bar.cornerStyle == 1 ? Theme.size.barHeight : Theme.size.barHeight + Theme.size.hyprlandGapsOut) : -root.windowHeight
            y: targetY

            anchors {
                left: parent.left
                right: parent.right
                leftMargin: 50
                rightMargin: 50
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
                    margins: container.spacing
                }

                ColumnLayout {
                    id: grid
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredHeight: parent.height
                    spacing: 10

                    GridLayout {
                        columns: 2
                        rowSpacing: 10
                        columnSpacing: rowSpacing
                        Layout.alignment: Qt.AlignTop

                        Rectangle {
                            implicitWidth: 300 + 10
                            implicitHeight: container.height + 2 * container.spacing - 30
                            color: Theme.color.sf00
                            radius: Theme.rounding.windowRounding
                            ScrollView {
                                clip: true
                                anchors {
                                    fill: parent
                                }
                                padding: 5
                                ListView {
                                    spacing: 5
                                    model: ScriptModel {
                                        values: NotificationDaemon.data.slice().reverse()
                                    }

                                    delegate: NotificationItem {
                                        id: child

                                        title: modelData?.summary
                                        body: modelData?.body
                                        image: modelData?.image || modelData?.appIcon
                                        rawNotification: modelData
                                        tracked: true
                                        buttons: modelData.actions.map(action => ({
                                                    label: action.text,
                                                    onClick: () => {
                                                        action.invoke();
                                                    }
                                                }))
                                    }
                                }
                            }
                        }
                    }
                }
                ColumnLayout {
                    StyledButton {
                        implicitWidth: 80
                        implicitHeight: 80
                        contentItem: StyledText {
                            text: "left"
                        }
                        onClicked: Quickshell.execDetached(["sh", "-c", "notify-send \"Заголовок\" \"Основной текст\""])
                    }
                    StyledButton {
                        implicitWidth: 80
                        implicitHeight: 80
                        contentItem: StyledText {
                            text: "left"
                        }
                        onClicked: Quickshell.execDetached(["sh", "-c", "notify-send \"Заголовок\" \"Основной текст\" --action=\"key1=Кнопка 1\" --action=\"key2=Кнопка 2\""])
                    }
                    StyledButton {
                        implicitWidth: 80
                        implicitHeight: 80
                        contentItem: StyledText {
                            text: "left"
                        }
                    }
                    StyledButton {
                        implicitWidth: 80
                        implicitHeight: 80
                        contentItem: StyledText {
                            text: "left"
                        }
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
