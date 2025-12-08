import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.components
import qs.services
import qs.config

Scope {
    id: root
    PanelWindow {
        id: dateMenuRoot
        anchors.top: true
        exclusionMode: ExclusionMode.Ignore
        color: "transparent"

        function hide() {
            GlobalStates.dateMenuOpen = false;
        }
        readonly property real openedHeight: container.height + 2 * container.spacing + Theme.size.barHeight + Theme.size.hyprlandGapsOut

        implicitWidth: container.implicitWidth + container.spacing * 2
        implicitHeight: shape.height > 0 ? openedHeight + 10 : 0

        visible: shape.height > 0

        mask: Region {
            item: shape
        }
        Shape {
            id: shape
            clip: true
            focus: true

            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape) {
                    dateMenuRoot.hide();
                }
            }

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: Theme.size.barHeight + Theme.size.hyprlandGapsOut
            }

            height: GlobalStates.dateMenuOpen ? container.height + 2 * container.spacing : 0
            onHeightChanged: if (height <= 0)
                dateMenuRoot.hide()

            Behavior on height {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            layer.enabled: true
            layer.samples: 4
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: Theme.color.shadow
                blurMax: 2
                autoPaddingEnabled: false
                paddingRect: Qt.rect(0, 0, parent.width, parent.height)
            }

            Rectangle {
                id: background
                width: shape.width
                height: shape.height
                radius: Theme.rounding.windowRounding
                color: Theme.color.bg00
                border {
                    width: 1
                    color: Theme.color.border00
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
                            implicitHeight: dateMenuRoot.openedHeight - 80
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
            windows: [dateMenuRoot]
            active: GlobalStates.dateMenuOpen
            onCleared: () => {
                if (!active)
                    dateMenuRoot.hide();
            }
        }
    }
    IpcHandler {
        target: "DateMenu"

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
