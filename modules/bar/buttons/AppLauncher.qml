import QtQuick
import QtQuick.Controls
import qs.components
import qs.settings

Button {
    id: root
    background: Rectangle {
        id: background

        color: Config.color.bg01
        border {
            color: Config.color.sf00
            width: 0.5
        }
        radius: 15
    }
    contentItem: Item {
        anchors.centerIn: parent
        implicitWidth: appLauncherIcon.font.pixelSize + 2
        implicitHeight: appLauncherIcon.font.pixelSize + 2

        MaterialSymbol {
            id: appLauncherIcon
            anchors.centerIn: parent
            font.pixelSize: 20
            icon: "rocket_launch"
            color: Config.color.fg
        }
    }
}
