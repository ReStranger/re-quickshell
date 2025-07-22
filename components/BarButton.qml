import QtQuick
import qs.settings

Item {
    id: root

    default property alias content: content.data

    implicitWidth: content.children.length > 0 ? content.children[0].implicitWidth + 10 : 0
    implicitHeight: content.children.length > 0 ? content.children[0].implicitHeight + 6 : 0

    Rectangle {
        id: background
        anchors.centerIn: parent
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight
        color: Config.color.bg01
        border {
            color: Config.color.sf00
            width: 0.5
        }
        radius: 15
    }
    Item {
        id: content
        anchors.centerIn: parent
    }
}
