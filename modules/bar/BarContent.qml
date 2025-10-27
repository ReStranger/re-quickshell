pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config

Item {
    id: root
    Loader {
        active: Config.options.bar.showBackground

        anchors.fill: barBackground
        sourceComponent: RectangularDownShadow {
            anchors.fill: undefined
            target: barBackground
        }
    }
    Rectangle {
        id: barBackground
        // opacity: 1 - (Config.options.theme.blur / 100)
        anchors {
            fill: parent
            margins: Config.options.bar.cornerStyle === 1 ? (Theme.size.hyprlandGapsOut / 2) : 0
            bottomMargin: Config.options.bar.cornerStyle === 1 ? (Theme.size.hyprlandGapsOut) : 0
        }
        color: Config.options.bar.showBackground ? Theme.color.bg00 : "transparent"
        radius: Config.options.bar.cornerStyle === 1 ? Theme.rounding.windowRounding : 0
        border.width: Config.options.bar.cornerStyle === 1 ? 1 : 0
        border.color: Theme.color.border00
        RowLayout {
            id: leftSection
            anchors {
                left: parent.left
                leftMargin: 7
                verticalCenter: parent.verticalCenter
            }
            AppLauncher {}
        }
        RowLayout {
            id: centerSection
            anchors.centerIn: parent
            DateButton {}
        }
        RowLayout {
            id: rightSection
            anchors {
                right: parent.right
                rightMargin: 7
                verticalCenter: parent.verticalCenter
            }
            SysTray {}
        }
    }
}
