//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

// Adjust this to make the shell smaller or larger
//@ pragma Env QT_SCALE_FACTOR=1

import QtQuick
import Quickshell
import qs.modules.bar
import qs.modules.quickSettings
import qs.modules.dateMenu
import qs.modules.notificationPopup

ShellRoot {
    id: root
    property bool enableBar: true
    property bool enableQS: true
    property bool enableDateMenu: true
    LazyLoader {
        active: root.enableQS
        component: QuickSettings {}
    }
    LazyLoader {
        active: root.enableDateMenu
        component: DateMenu {}
    }
    LazyLoader {
        active: root.enableBar
        component: Bar {}
    }
    LazyLoader {
        active: true
        component: NotificationPopup {}
    }
}
