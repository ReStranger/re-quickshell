pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import qs.config

Scope {
    id: bar
    Variants {
        model: Quickshell.screens
        LazyLoader {
            id: barLoader
            active: GlobalStates.barOpen && !GlobalStates.screenLocked
            required property ShellScreen modelData
            component: PanelWindow {
                id: barRoot
                screen: barLoader.modelData
                anchors {
                    top: !Config.options.bar.bottom
                    bottom: Config.options.bar.bottom
                    left: true
                    right: true
                }
                implicitHeight: Theme.size.barHeight + Theme.rounding.screenRounding
                exclusionMode: ExclusionMode.Ignore
                exclusiveZone: Theme.size.baseBarHeight + (Config.options.bar.cornerStyle === 1 ? Theme.size.hyprlandGapsOut : 0)

                mask: Region {
                    item: barContent
                }
                color: "transparent"

                BarContent {
                    id: barContent
                    implicitHeight: Theme.size.barHeight
                    anchors {
                        right: parent.right
                        left: parent.left
                        top: parent.top
                        bottom: undefined
                    }

                    states: State {
                        name: "bottom"
                        when: Config.options.bar.bottom
                        AnchorChanges {
                            target: barContent
                            anchors {
                                right: parent.right
                                left: parent.left
                                top: undefined
                                bottom: parent.bottom
                            }
                        }
                        PropertyChanges {
                            target: barContent
                        }
                    }
                }
                Loader {
                    id: screenCorners
                    anchors {
                        top: barContent.bottom
                        left: parent.left
                        right: parent.right
                        bottom: undefined
                    }
                    height: Theme.rounding.screenRounding
                    active: Config.options.bar.showBackground && Config.options.bar.cornerStyle === 0 // Hug
                    states: State {
                        name: "bottom"
                        when: Config.options.bar.bottom
                        AnchorChanges {
                            target: screenCorners
                            anchors {
                                right: barContent.right
                                left: barContent.left
                                top: undefined
                                bottom: barContent.top
                            }
                        }
                    }
                    sourceComponent:  ScreenCorners {}
                }
            }
        }
    }
}
