import QtQuick
import QtQuick.Effects

RectangularShadow {
    required property var target
    anchors.fill: target
    radius: target.radius
    offset.x: 2
    offset.y: 3
    blur: 9
    spread: 1
    color: "#121214"
    cached: true
}
