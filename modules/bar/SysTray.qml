pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick.Layouts
import qs.components
import qs.utils
import qs.config

Item {
    id: root

    readonly property Repeater items: items
    property var bar: root.QsWindow.window

    visible: SystemTray.items
    implicitWidth: rowLayout.implicitWidth + 15
    implicitHeight: rowLayout.implicitHeight + 12

    ShadowButton {
        visible: !Config.options.bar.showBackground
        anchors.fill: parent
        radius: Theme.rounding.windowRounding / 1.2
        fillColor: ColorUtils.transparentize(Theme.color.fg, 94 / 100)
        borderColor: ColorUtils.transparentize("#eeeeee", 94 / 100)
        borderWidth: 1
        Behavior on fillColor {
            ColorAnimation {
                duration: 100
                easing.type: Easing.Linear
            }
        }
    }

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
                implicitWidth: 16
                implicitHeight: 20

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
