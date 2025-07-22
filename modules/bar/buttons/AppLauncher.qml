import QtQuick
import qs.components
import qs.settings

BarButton {
    id: root
    MaterialSymbol {
        id: appLauncherIcon
        anchors.centerIn: parent
        font.pixelSize: 20
        icon: "rocket_launch"
        color: Config.color.fg
    }
}
