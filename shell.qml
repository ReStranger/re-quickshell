//@ pragma UseQApplication
import Quickshell
import QtQuick
import qs.modules.bar
import qs.modules.dateMenu
import qs.modules.quickSettings
import qs.modules.roundedCorners

ShellRoot {
    id: root
    property bool enableBar: true

    LazyLoader {
        active: root.enableBar
        component: Bar {}
    }
    LazyLoader {
        active: true
        component: RoundedCorners {}
    }
    LazyLoader {
        active: true
        component: DateMenu {}
    }
    LazyLoader {
        active: true
        component: QuickSettings {}
    }
}
