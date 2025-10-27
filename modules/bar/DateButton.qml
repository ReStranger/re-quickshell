pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.components
import qs.utils
import qs.services
import qs.config

StyledButton {
    id: root
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    property bool isDateVisible

    onClicked: function (mouse) {
        if (mouse.button === Qt.LeftButton) {
            GlobalStates.dateMenuOpen = !GlobalStates.dateMenuOpen;
        } else if (mouse.button === Qt.RightButton) {
            isDateVisible = !isDateVisible;
        }
    }
    onEntered: {
        isDateVisible = !isDateVisible;
    }

    contentItem: RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        anchors.margins: 5

        MaterialSymbol {
            id: clockIcon
            icon: "schedule"
            color: root.enabled ? (root.pressed ? Theme.color.bg00 : Theme.color.fg) : Theme.color.sf01
            font.pixelSize: 20
        }

        StyledText {
            id: clockText
            text: DateTime.time
            color: root.enabled ? (root.pressed ? Theme.color.bg00 : Theme.color.fg) : Theme.color.sf01
            font.pixelSize: 16
        }
        StyledText {
            id: dot
            visible: root.isDateVisible
            text: "•"
            color: root.enabled ? (root.pressed ? Theme.color.bg00 : Theme.color.fg) : Theme.color.sf01
            font.pixelSize: 20
        }
        StyledText {
            id: dateText

            Layout.leftMargin: !root.isDateVisible ? -width : 0
            Layout.rightMargin: root.isDateVisible ? 5 : 0

            scale: root.isDateVisible ? 1.0 : 0.5
            opacity: root.isDateVisible ? 1 : 0

            text: Utils.capitalize(DateTime.date.weekDayShort) + " " + DateTime.date.shortDate
            color: root.enabled ? (root.pressed ? Theme.color.bg00 : Theme.color.fg) : Theme.color.sf01

            font.pixelSize: 16

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on scale {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on Layout.leftMargin {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}
