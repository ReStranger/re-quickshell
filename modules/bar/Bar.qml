pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.modules.bar
import qs.modules.bar.buttons
import qs.settings

Scope {
    id: bar
    Variants {
        model: Quickshell.screens
        LazyLoader {
            id: barLoader
            active: true // TODO: Add opt to disable
            required property ShellScreen modelData
            component: PanelWindow {
                id: barRoot

                screen: barLoader.modelData // FIXME

                anchors {
                    top: true
                    left: true
                    right: true
                }
                implicitHeight: Config.size.barHeight + Config.rounding.screenRounding
                exclusionMode: ExclusionMode.Ignore
                exclusiveZone: Config.size.barHeight
                WlrLayershell.namespace: "quickshell:bar"
                mask: Region {
                    item: barContent
                }
                color: "transparent"

                Item {
                    id: barContent
                    anchors {
                        right: parent.right
                        left: parent.left
                        top: parent.top
                        bottom: undefined
                    }
                    implicitHeight: Config.size.barHeight
                    height: Config.size.barHeight

                    Rectangle {
                        id: barBackground
                        anchors.fill: parent
                        color: Config.color.bg00
                    }
                    Item {
                        id: leftRow
                        anchors {
                            left: parent.left
                            leftMargin: 5
                            verticalCenter: parent.verticalCenter
                        }
                        implicitWidth: leftRowLayout.implicitWidth
                        implicitHeight: leftRowLayout.implicitHeight

                        RowLayout {
                            id: leftRowLayout
                            anchors.fill: parent
                            spacing: 20
                            AppLauncher {}
                        }
                    }
                    Item {
                        id: centerRow
                        anchors.centerIn: parent
                        implicitWidth: centerRowLayout.implicitWidth
                        implicitHeight: centerRowLayout.implicitHeight

                        RowLayout {
                            id: centerRowLayout
                            anchors.fill: parent
                            spacing: 20
                            DateButton {}
                        }
                    }
                    Item {
                        id: rightRow
                        anchors {
                            right: parent.right
                            rightMargin: 5
                            verticalCenter: parent.verticalCenter
                        }
                        implicitWidth: rightRowLayout.implicitWidth
                        implicitHeight: rightRowLayout.implicitHeight

                        RowLayout {
                            id: rightRowLayout
                            anchors.fill: parent
                            spacing: 20
                            SysTray {}
                            SystemIndicators {}
                        }
                    }
                }
                Loader {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    y: Config.size.barHeight
                    width: parent.width
                    height: Config.rounding.screenRounding
                    active: true
                    sourceComponent: ScreenCorners {}
                }
            }
        }
    }
}
