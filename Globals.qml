pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell

Singleton {
    id: root

    property bool visibleQS: false

    property bool visibleDateMenu: false

    signal _toggleQS
    signal _toggleDateMenu

    function toggleQS() {
        visibleQS = !visibleQS
        _toggleQS()
    }

    function toggleDateMenu() {
        visibleDateMenu = !visibleDateMenu
        _toggleDateMenu()
    }
}
