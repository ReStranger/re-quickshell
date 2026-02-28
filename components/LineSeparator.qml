import QtQuick
import qs.config

Rectangle {
    id: root

    property real thickness: 1

    implicitHeight: thickness
    height: implicitHeight
    color: Theme.color.border00
}
