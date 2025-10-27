import QtQuick
import QtQuick.Layouts
import qs.utils
import qs.components
import qs.config

Item {
    id: root
    implicitWidth: 150
    implicitHeight: 40
    property string name
    property string subName
    property string icon
    property bool haveSubName: false
    property bool haveMenu: false
    property bool isToggleOpen: false
    property bool toggled: false

    property color disabledColor: Theme.color.bg00
    property color defaultColor: ColorUtils.transparentize(Theme.color.fg, 94 / 100)
    property color hoveredColor: Theme.color.sf00
    property color pressedColor: Theme.color.primary

    signal clicked()

    RowLayout {
        spacing: 0

        MouseArea {
            id: menuButton
            implicitWidth: root.haveMenu ? 120 : root.implicitWidth
            implicitHeight: 40
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                root.clicked();
            }

            Rectangle {
                anchors.fill: parent
                topLeftRadius: Theme.rounding.windowRounding / 1.2
                bottomLeftRadius: Theme.rounding.windowRounding / 1.2
                topRightRadius: root.haveMenu ? 0 : Theme.rounding.windowRounding / 1.2
                bottomRightRadius: root.haveMenu ? 0 : Theme.rounding.windowRounding / 1.2

                color: root.toggled ? Theme.color.primary : Theme.color.sf00
                Rectangle {
                    anchors.fill: parent
                    color: ColorUtils.transparentize(Theme.color.fg, 0.8)
                    visible: menuButton.pressed
                    topLeftRadius: Theme.rounding.windowRounding / 1.2
                    bottomLeftRadius: Theme.rounding.windowRounding / 1.2
                    topRightRadius: root.haveMenu ? 0 : Theme.rounding.windowRounding / 1.2
                    bottomRightRadius: root.haveMenu ? 0 : Theme.rounding.windowRounding / 1.2
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 100
                        easing.type: Easing.Linear
                    }
                }
            }
            Item {
                anchors.fill: parent

                MaterialSymbol {
                    id: menuIcon
                    leftPadding: 7
                    rightPadding: 5
                    Layout.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 22
                    icon: root.icon
                    color: root.toggled ? Theme.color.bg00 : Theme.color.fg
                }
                ColumnLayout {
                    anchors.left: menuIcon.right
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    StyledText {
                        text: root.name
                        fontSize: 14
                        fontColor: root.toggled ? Theme.color.bg00 : Theme.color.fg
                        fontWeight: Font.Bold
                    }
                    StyledText {
                        visible: root.haveSubName
                        text: root.subName
                        fontSize: 10
                        fontColor: root.toggled ? Theme.color.bg00 : Theme.color.fg
                        fontWeight: Font.Light
                    }
                }
            }
        }
        MouseArea {
            id: arrowButton
            visible: root.haveMenu
            implicitWidth: 30
            implicitHeight: 40
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                root.isToggleOpen = !root.isToggleOpen;
            }

            Rectangle {
                anchors.fill: parent
                topLeftRadius: 0
                bottomLeftRadius: 0
                topRightRadius: Theme.rounding.windowRounding / 1.2
                bottomRightRadius: Theme.rounding.windowRounding / 1.2

                color: root.toggled ? Theme.color.primary : Theme.color.sf00
                Rectangle {
                    anchors.fill: parent
                    color: ColorUtils.transparentize(Theme.color.fg, 0.8)
                    visible: arrowButton.pressed
                    topLeftRadius: 0
                    bottomLeftRadius: 0
                    topRightRadius: Theme.rounding.windowRounding / 1.2
                    bottomRightRadius: Theme.rounding.windowRounding / 1.2
                }
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                        easing.type: Easing.Linear
                    }
                }
            }

            Item {
                anchors.centerIn: parent
                implicitWidth: arrowIcon.font.pixelSize + 2
                implicitHeight: arrowIcon.font.pixelSize + 2

                MaterialSymbol {
                    id: arrowIcon
                    property real arrowAngle: 0
                    anchors.centerIn: parent
                    font.pixelSize: 25
                    icon: "keyboard_arrow_right"
                    color: root.toggled ? Theme.color.bg00 : Theme.color.fg
                    rotation: root.isToggleOpen ? 90 : 0
                    Behavior on rotation {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }
        }
    }
}
