import QtQuick
import Quickshell
import qs
import qs.components

PopupWindow {
    id: dateMenu
    animOnHeight: true
    isVisible: Globals.visibleDateMenu
    toggleFunction: () => Globals.toggleDateMenu()
    anchors {
        top: true
    }
}
