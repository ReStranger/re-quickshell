import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.components
import qs.services
import qs.config

Scope {
    id: root
    PanelWindow {
        id: popupRoot
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        anchors {
            top: true
            right: true
            bottom: true
        }

        readonly property real barMargin: Config.options.bar.cornerStyle == 1 ? Theme.size.barHeight : Theme.size.barHeight + Theme.size.hyprlandGapsOut

        implicitWidth: container.implicitWidth + Theme.size.hyprlandGapsOut + 60
        implicitHeight: container.implicitHeight + barMargin

        visible: !GlobalStates.dndEnabled

        mask: Region {
            item: container
        }
        ListView {
            id: container
            implicitWidth: Theme.size.notification
            implicitHeight: contentHeight
            interactive: false
            spacing: 5
            model: ScriptModel {
                values: NotificationDaemon.data.filter(n => n.popup && !n.tracked)
            }
            anchors {
                top: !Config.options.bar.bottom ? parent.top : undefined
                left: parent.left
                bottom: Config.options.bar.bottom ? parent.bottom : undefined
                topMargin: !Config.options.bar.bottom ? popupRoot.barMargin : 0
                leftMargin: 60
                bottomMargin: Config.options.bar.bottom ? popupRoot.barMargin : 0
            }
            move: Transition {
                NumberAnimation {
                    property: "y"
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }

            displaced: Transition {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                }
            }

            delegate: NotificationItem {
                id: child

                title: modelData.summary || ""
                body: modelData.body || ""
                image: modelData.image || modelData.appIcon
                rawNotification: modelData
                tracked: modelData.shown || !(modelData.shown = true)
                buttons: modelData.actions.map(action => ({
                            label: action.text,
                            onClick: () => {
                                action.invoke();
                            }
                        }))
                border {
                    width: 1
                    color: Theme.color.border00
                }
                ListView.onAdd: addAnim.start()
                ListView.onRemove: removeAnim.start()

                NumberAnimation {
                    id: addAnim
                    target: child
                    property: "x"
                    from: Theme.size.notification
                    to: 0
                    duration: 600
                    easing.type: Easing.OutBack
                }
                SequentialAnimation {
                    id: removeAnim
                    PropertyAction {
                        target: child
                        property: "ListView.delayRemove"
                        value: true
                    }
                    PropertyAction {
                        target: child
                        property: "enabled"
                        value: false
                    }
                    PropertyAction {
                        target: child
                        property: "implicitHeight"
                        value: 0
                    }
                    PropertyAction {
                        target: child
                        property: "z"
                        value: 1
                    }

                    NumberAnimation {
                        target: child
                        property: "x"
                        from: 0
                        to: Theme.size.notification * 1.1
                        duration: 400
                        easing.type: Easing.OutExpo
                    }
                    PropertyAction {
                        target: child
                        property: "ListView.delayRemove"
                        value: false
                    }
                }
            }
        }
    }
}
