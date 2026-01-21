import QtQuick
import qs.components
import qs.utils
import qs.config

Item {
    implicitHeight: Theme.rounding.screenRounding

    RoundCorner {
        id: leftCorner
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
        }

        implicitSize: Theme.rounding.screenRounding
        color: Config.options.theme.showBackground ? Theme.color.bg00 : ColorUtils.transparentize(Theme.color.bg00, 0.89)
        borderColor: Theme.color.border00
        borderWidth: 1

        corner: RoundCorner.CornerEnum.TopLeft
        states: State {
            name: "bottom"
            when: Config.options.bar.bottom
            PropertyChanges {
                leftCorner.corner: RoundCorner.CornerEnum.BottomLeft
            }
        }
    }

    RoundCorner {
        id: rightCorner
        anchors {
            right: parent.right
            top: !Config.options.bar.bottom ? parent.top : undefined
            bottom: Config.options.bar.bottom ? parent.bottom : undefined
        }
        implicitSize: Theme.rounding.screenRounding
        color: Config.options.theme.showBackground ? Theme.color.bg00 : ColorUtils.transparentize(Theme.color.bg00, 0.89)
        borderColor: Theme.color.border00
        borderWidth: 1

        corner: RoundCorner.CornerEnum.TopRight
        states: State {
            name: "bottom"
            when: Config.options.bar.bottom
            PropertyChanges {
                rightCorner.corner: RoundCorner.CornerEnum.BottomRight
            }
        }
    }
}
