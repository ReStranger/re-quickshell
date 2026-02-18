pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick.Layouts
import qs.components
import qs.config

StyledButton {
    id: root

    readonly property Repeater items: items
    property var bar: root.QsWindow.window

    visible: SystemTray.items
    implicitWidth: rowLayout.implicitWidth + 14
    implicitHeight: rowLayout.implicitHeight + 14

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent

        spacing: 10

        Repeater {
            id: items

            model: SystemTray.items

            MouseArea {
                id: mouseArea

                required property SystemTrayItem modelData

                acceptedButtons: Qt.LeftButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor
                implicitWidth: 16
                implicitHeight: 16

                onClicked: event => {
                    switch (event.button) {
                    case Qt.LeftButton:
                        modelData.activate();
                        break;
                    case Qt.RightButton:
                        if (modelData.hasMenu)
                            menu.open();
                        break;
                    }
                }

                IconImage {
                    id: icon

                    source: {
                        let icon = mouseArea.modelData.icon;
                        if (icon.includes("?path=")) {
                            const [name, path] = icon.split("?path=");
                            icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
                        }
                        return icon;
                    }
                    asynchronous: true
                    anchors.fill: parent
                }
                QsMenuAnchor {
                    id: menu

                    menu: mouseArea.modelData.menu
                    anchor {
                        window: root.bar
                        margins.top: Theme.size.baseBarHeight
                        rect {
                            x: root.x + root.bar?.width
                            height: root.height
                        }
                        edges: Edges.Bottom
                    }
                }
            }
        }
    }
}
