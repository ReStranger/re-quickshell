import QtQuick
import QtQuick.Effects

MultiEffect {
    required property Item sourceComponent
    anchors.fill: sourceComponent
    source: sourceComponent
    enabled: false
    shadowEnabled: true
    shadowColor: "#121214"
    shadowBlur: 1
    shadowHorizontalOffset: 2
    shadowVerticalOffset: 3
}
