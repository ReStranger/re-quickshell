import QtQuick
import QtQuick.Effects
import qs.config

RectangularShadow {
    required property var target
    anchors.fill: target
    radius: target.radius
    blur: 0.9 * 10
    offset: Qt.vector2d(0.0, 5.0)
    spread: 1
    color: Theme.color.shadow
    cached: true
}
