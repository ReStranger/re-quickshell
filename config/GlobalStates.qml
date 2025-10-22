pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell

Singleton {
    id: root
    property bool barOpen: true
    property bool qsOpen: false
    property bool dateMenuOpen: false
    property bool screenLocked: false
}
