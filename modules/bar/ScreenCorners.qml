import QtQuick
import qs.settings
import qs.components

Item {
    id: root
    implicitHeight: Config.rounding.screenRounding

    RoundCorner {
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
        }
        corner: RoundCorner.CornerEnum.TopLeft
        implicitSize: Config.rounding.screenRounding
        color: Config.color.bg00
    }
    RoundCorner {
        anchors {
            top: parent.top
            right: parent.right
        }
        corner: RoundCorner.CornerEnum.TopRight
        implicitSize: Config.rounding.screenRounding
        color: Config.color.bg00
    }
}
