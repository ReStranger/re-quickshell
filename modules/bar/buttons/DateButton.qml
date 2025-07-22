import QtQuick
import QtQuick.Layouts
import qs
import qs.components
import qs.settings
import qs.services

BarButton {
    id: root

    property bool isDateVisible

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent

        MaterialSymbol {
            id: clockIcon
            icon: "schedule"
            color: Config.color.fg
            font.pixelSize: 20
        }

        StyledText {
            id: clockText
            text: DateTime.time.hours + ":" + DateTime.time.minutes
            font.pixelSize: 16
        }
        StyledText {
            id: dot
            visible: root.isDateVisible
            text: "•"
            font.pixelSize: 20
        }
        StyledText {
            id: dateText

            Layout.leftMargin: !root.isDateVisible ? -width : 0

            scale: root.isDateVisible ? 1.0 : 0.5
            opacity: root.isDateVisible ? 1 : 0

            text: DateTime.date.weekDayShort[0].toUpperCase() + DateTime.date.weekDayShort[1] + " " + DateTime.date.day + "/" + DateTime.date.month
            font.pixelSize: 16

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
            Behavior on Layout.leftMargin {
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
        onEntered: {
            root.isDateVisible = !root.isDateVisible;
        }
        onClicked: Globals.toggleDateMenu()
    }
}
