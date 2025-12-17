import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
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

        readonly property real openedHeight: container.height + 2 * container.spacing + Theme.size.barHeight + Theme.size.hyprlandGapsOut

        implicitWidth: container.implicitWidth + container.spacing * 2
        implicitHeight: background.height > 0 ? openedHeight + 10 : 0

        visible: background.height > 0

        mask: Region {
            item: shape
        }

        Rectangle {
            id: background
            focus: true
            clip: true

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: Theme.size.barHeight + Theme.size.hyprlandGapsOut
            }

            height: GlobalStates.dateMenuOpen ? container.height + 2 * container.spacing : 0
            color: Theme.color.bg00
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

            RowLayout {
                id: container
                spacing: Theme.rounding.windowRounding

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
                            implicitHeight: root.openedHeight - 80
                            color: Theme.color.sf00
                            radius: 10
                            ScrollView {
                                clip: true
                                anchors {
                                    fill: parent
                                    leftMargin: 5
                                }
                                Column {
                                    spacing: 5
                                    Repeater {
                                        id: rep

                                        model: Array.from(NotificationDaemon.data).reverse()

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
    IpcHandler {
        target: "DateMenu"

        function toggle(): void {
            GlobalStates.dateMenuOpen = !GlobalStates.dateMenuOpen;
        }

        function close(): void {
            GlobalStates.dateMenuOpen = false;
        }

        function open(): void {
            GlobalStates.dateMenuOpen = true;
        }
    }
}
