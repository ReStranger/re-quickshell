import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config

Rectangle {
    id: root
    radius: 16
    color: Theme.color.sf00
    clip: true

    property string menuName: "Menu Name"
    property string menuIcon: "settings"
    property string menuButtonName: "All settings"
    property var menuButtonAction: () => {}

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Rectangle {
                implicitWidth: 30
                implicitHeight: 30
                radius: 15
                color: Theme.color.primary
                MaterialSymbol {
                    anchors.centerIn: parent
                    icon: root.menuIcon
                    implicitSize: 16
                }
            }

            StyledText {
                text: root.menuName
                color: Theme.color.fg
                font.pixelSize: 18
                font.weight: 600
                Layout.fillWidth: true
            }

            Item {
                Layout.fillWidth: true
            }
            // StyledSwitch {}
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.leftMargin: 2
            Layout.rightMargin: 2
            implicitHeight: 1
            color: Theme.color.border00
        }

        ListView {
            id: list
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 8
            model: 100
            delegate: StyledButton {
                implicitWidth: ListView.view.width
                implicitHeight: 30
                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 8
                    MaterialSymbol {
                        text: "wifi"
                        color: "#cfcfd2"
                        font.pixelSize: 16
                    }
                    StyledText {
                        text: "Network " + (index + 1)
                        color: "#cfcfd2"
                        font.pixelSize: 14
                        Layout.fillWidth: true
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    MaterialSymbol {
                        text: "check"
                        color: "#cfcfd2"
                        font.pixelSize: 14
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.leftMargin: 2
            Layout.rightMargin: 2
            implicitHeight: 1
            color: Theme.color.border00
        }
        StyledButton {
            Layout.fillWidth: true
            text: root.menuButtonName
            onClicked: root.menuButtonAction
        }
    }
}
