pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.modules.bar.systemStats
import qs.components
import qs.utils
import qs.config

Item {
    id: root
    Loader {
        active: Config.options.theme.showBackground

        anchors.fill: background
        sourceComponent: WindowShadow {
            sourceComponent: background
        }
    }
    Rectangle {
        id: background
        anchors {
            fill: parent
            margins: Config.options.bar.cornerStyle === 1 ? (Theme.size.hyprlandGapsOut / 2) : 0
            bottomMargin: Config.options.bar.cornerStyle === 1 ? (Theme.size.hyprlandGapsOut) : 0
        }
        color: Config.options.theme.showBackground ? Theme.color.bg00 : ColorUtils.transparentize(Theme.color.bg00, 0.89)
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
            SystemStats {}
            BatteryIndicator {}
            SysTray {}
            SystemIndicators {}
        }
    }
}
