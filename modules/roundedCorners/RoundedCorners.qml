pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import qs.settings
import qs.components

Scope {
    id: root
    Variants {
        model: Quickshell.screens
        LazyLoader {
            id: roundedCornersLoader
            active: true // TODO: Add opt to disable
            required property ShellScreen modelData
            component: PanelWindow {
                id: roundedCornersRoot

                property HyprlandMonitor monitor: Hyprland.monitorFor(roundedCornersLoader.modelData)
                property list<HyprlandWorkspace> workspacesForMonitor: Hyprland.workspaces.values.filter(workspace => workspace.monitor && workspace.monitor.name == monitor.name)
                property var activeWorkspaceWithFullscreen: workspacesForMonitor.filter(workspace => ((workspace.toplevels.values.filter(window => window.wayland?.fullscreen)[0] != undefined) && workspace.active))[0]
                property bool fullscreen: activeWorkspaceWithFullscreen != undefined

                screen: roundedCornersLoader.modelData // FIXME
                visible: (Config.rounding.screenRounding !== 0 && !fullscreen)

                anchors {
                    top: true
                    left: true
                    right: true
                }
                implicitWidth: 1920
                implicitHeight: 1080
                exclusionMode: ExclusionMode.Ignore
                WlrLayershell.layer: WlrLayer.Overlay
                color: "transparent"
                mask: Region {
                    item: null
                }
                // WlrLayershell.namespace: "quickshell:bar"
                Item {
                    implicitWidth: 1920
                    implicitHeight: 1080
                    RoundCorner {
                        anchors {
                            top: parent.top
                            left: parent.left
                            bottom: parent.bottom
                        }
                        corner: RoundCorner.CornerEnum.TopLeft
                        implicitSize: Config.rounding.screenRounding
                        color: "black"
                    }
                    RoundCorner {
                        anchors {
                            top: parent.top
                            right: parent.right
                        }
                        corner: RoundCorner.CornerEnum.TopRight
                        implicitSize: Config.rounding.screenRounding
                        color: "black"
                    }
                    RoundCorner {
                        anchors {
                            left: parent.left
                            bottom: parent.bottom
                        }
                        corner: RoundCorner.CornerEnum.BottomLeft
                        implicitSize: Config.rounding.screenRounding
                        color: "black"
                    }
                    RoundCorner {
                        anchors {
                            right: parent.right
                            bottom: parent.bottom
                        }
                        corner: RoundCorner.CornerEnum.BottomRight
                        implicitSize: Config.rounding.screenRounding
                        color: "black"
                    }
                }
            }
        }
    }
}
