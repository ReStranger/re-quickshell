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

        implicitWidth: container.implicitWidth + Theme.size.hyprlandGapsOut + 20
        // implicitHeight: container.implicitHeight + barMargin

        visible: !GlobalStates.dndEnabled && NotificationDaemon.popups.length > 0

        mask: Region {
            item: container
        }
        Column {
            id: container
            anchors {
                top: !Config.options.bar.bottom ? parent.top : undefined
                left: parent.left
                bottom: Config.options.bar.bottom ? parent.bottom : undefined
                topMargin: !Config.options.bar.bottom ? popupRoot.barMargin : 0
                leftMargin: 20 // reserved for animation
                bottomMargin: Config.options.bar.bottom ? popupRoot.barMargin : 0
            }
            spacing: 5
            Repeater {
                id: rep
                anchors.fill: parent
                model: NotificationDaemon.popups

                delegate: NotificationItem {
                    id: child

                    title: modelData.summary || ""
                    body: modelData.body || ""
                    image: modelData.image || modelData.appIcon
                    rawNotification: modelData
                    // tracked: modelData.shown || !(modelData.shown = true)
                    buttons: modelData.actions.map(action => ({
                                label: action.text,
                                onClick: () => {
                                    action.invoke();
                                }
                            }))
                    onExited: exitAnim.start()
                    x: modelData.shown ? 0 : 100

                    Component.onCompleted: {
                        if (!modelData.shown) {
                            entryAnim.start();
                            modelData.shown = true;
                        }
                    }

                    ParallelAnimation {
                        id: entryAnim

                        NumberAnimation {
                            target: child
                            property: "x"
                            to: 0
                            duration: 400
                            easing.type: Easing.OutBack
                        }
                    }
                }
            }
        }
    }
}
