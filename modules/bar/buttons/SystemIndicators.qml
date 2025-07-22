import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import qs
import qs.settings
import qs.components
import qs.services

Button {
    id: root

    checkable: true
    onToggled: Globals.toggleQS()

    background: Rectangle {
        id: background

        color: Config.color.bg01
        border {
            color: Config.color.sf00
            width: 0.5
        }
        radius: 15
    }
    contentItem: RowLayout {
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
            implicitWidth: networkIcon.implicitWidth + 4
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
}
