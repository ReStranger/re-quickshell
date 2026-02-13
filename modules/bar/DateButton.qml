pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.components
import qs.utils
import qs.services
import qs.config

StyledButton {
    id: root
    // acceptedButtons: Qt.LeftButton | Qt.RightButton
    checked: GlobalStates.dateMenuOpen

    property bool isDateVisible
    // property color textColor: root.enabled ? ((root.toggled || root.pressed) ? Theme.color.bg00 : Theme.color.fg) : Theme.color.sf01

    onClicked: GlobalStates.dateMenuOpen = !GlobalStates.dateMenuOpen
    altAction: () => {
        isDateVisible = !isDateVisible;
    }

    contentItem: RowLayout {
        id: rowLayout

        MaterialSymbol {
            id: clockIcon
            icon: "schedule"
            color: root.foregroundColor
            font.pixelSize: 18
        }

        StyledText {
            id: clockText
            text: DateTime.time
            color: root.foregroundColor
            font.pixelSize: 16
            font.weight: Font.Bold
        }
        StyledText {
            id: dot
            visible: root.isDateVisible
            text: "•"
            color: root.foregroundColor
            font.pixelSize: 20
        }
        StyledText {
            id: dateText

            Layout.leftMargin: !root.isDateVisible ? -width : 0
            Layout.rightMargin: root.isDateVisible ? 5 : 0

            scale: root.isDateVisible ? 1.0 : 0.5
            opacity: root.isDateVisible ? 1 : 0

            text: Utils.capitalize(DateTime.date.weekDayShort) + " " + DateTime.date.shortDate
            color: root.foregroundColor

            font.pixelSize: 16
            font.weight: Font.Bold

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
