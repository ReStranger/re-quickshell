import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.components
import qs.settings

Item {
    id: root
    implicitWidth: rowLayout.implicitWidth
    implicitHeight: rowLayout.implicitHeight

    default property alias text: menuText.text

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        spacing: 4

        Button {
            id: mainButton

            contentItem: RowLayout {
                anchors.leftMargin: 10
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                spacing: 4

                Item {
                    implicitWidth: menuIcon.font.pixelSize
                    implicitHeight: menuIcon.font.pixelSize

                    anchors.verticalCenter: parent.verticalCenter

                    MaterialSymbol {
                        id: menuIcon
                        anchors.centerIn: parent
                        icon: "lock"
                        font.pixelSize: 24
                    }
                }
                Text {
                    id: menuText
                    font.pixelSize: 16
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    elide: Text.ElideRight
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            background: Rectangle {
                implicitWidth: 130
                implicitHeight: 35
                color: Config.color.primary
                radius: 15
                topRightRadius: 15 / 4
                bottomRightRadius: 15 / 4
            }
        }

        Button {
            id: arrowButton

            background: Rectangle {
                implicitWidth: 25
                implicitHeight: 35
                color: Config.color.primary
                radius: 15
                topLeftRadius: 15 / 4
                bottomLeftRadius: 15 / 4
            }
        }
    }
}
