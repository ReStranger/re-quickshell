import QtQuick.Layouts
import QtQuick
import qs
import qs.settings
import qs.components
import qs.services

BarButton {
    id: root

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        Item {
            id: audio

            property string icon
            opacity: audio.visible ? 1.0 : 0.0
            scale: audio.visible ? 1.0 : 0.9

            implicitWidth: audioIcon.implicitWidth
            implicitHeight: audioIcon.implicitWidth

            visible: Audio.defaultSink.icon !== ""

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }

            MaterialSymbol {
                id: audioIcon
                anchors.centerIn: parent
                property var pwTracker: Audio.pwTracker
                font.pixelSize: 20
                icon: Audio.defaultSink.icon
                color: Config.color.fg
            }
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
            Behavior on scale {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
        Item {
            id: network
            implicitWidth: networkIcon.implicitWidth
            implicitHeight: networkIcon.implicitWidth

            opacity: audio.visible ? 1.0 : 0.0
            scale: audio.visible ? 1.0 : 0.9

            visible: Network.icon !== ""

            MaterialSymbol {
                id: networkIcon
                anchors.centerIn: parent
                font.pixelSize: 20
                icon: Network.icon
                color: Config.color.fg
            }
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
            Behavior on scale {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: rowLayout
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: Globals.toggleQS()
    }
}
