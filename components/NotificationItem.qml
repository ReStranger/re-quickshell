import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs.components
import qs.config

Rectangle {
    id: root

    property string title: "No app"
    property string body: "No content"
    property var rawNotification: null
    property bool tracked: false
    property string image: ""
    property bool hovered: false
    property bool showButtons: root.hovered && root.buttons.length > 1

    property var buttons: []

    signal entered
    signal exited

    function dismiss() {
        root.rawNotification?.notification.dismiss();
    }

    color: Theme.color.bg00
    implicitWidth: 300
    implicitHeight: content.implicitHeight + 20
    radius: 15

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton

        onClicked: {
            if (root.showButtons) {
                root.buttons[0].onClick();
            }
            root.dismiss();
        }
    }

    ColumnLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 10
        spacing: 0
        RowLayout {
            Rectangle {
                clip: true
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                radius: 100
                border {
                    width: 1
                    color: Theme.color.border00
                }

                Image {
                    width: 50
                    height: 50
                    anchors.fill: parent
                    source: root.image
                    fillMode: Image.PreserveAspectCrop
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle {
                            width: 50
                            height: 50
                            radius: 100
                        }
                    }
                }
            }
            ColumnLayout {
                Layout.fillHeight: true
                RowLayout {
                    StyledText {
                        text: root.title.length > 26 ? root.title.substr(0, 23) + "..." : root.title
                        font.pixelSize: 16
                        font.weight: Font.Bold
                        color: Theme.color.fg

                        Layout.fillWidth: true
                    }
                    MouseArea {
                        id: closeButtonArea
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        implicitWidth: closeButton.implicitWidth
                        implicitHeight: closeButton.implicitHeight

                        onClicked: root.dismiss()

                        MaterialSymbol {
                            id: closeButton
                            anchors.centerIn: parent
                            icon: "close"
                            iconSize: 22
                            color: Theme.color.fg
                        }
                    }
                }

                StyledText {
                    text: root.body.length > 37 ? root.body.substr(0, 34) + "..." : root.body
                    visible: root.body.length > 0
                    font.pixelSize: 12
                    color: Theme.color.fg

                    Layout.fillWidth: true
                }
            }
        }
        RowLayout {
            id: buttonsLayout
            clip: true
            spacing: 10
            opacity: root.showButtons ? 1 : 0

            Layout.preferredHeight: root.showButtons ? 25 : 0
            Layout.fillWidth: true
            Layout.topMargin: root.showButtons ? 10 : 0

            Behavior on Layout.preferredHeight {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on Layout.topMargin {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }

            Repeater {
                Layout.fillWidth: true
                model: root.buttons

                StyledButton {
                    id: notificationButton
                    Layout.fillWidth: true
                    implicitHeight: 25
                    implicitWidth: 0
                    contentItem: StyledText {
                        property color textColor: notificationButton.pressed ? Theme.color.bg00 : Theme.color.fg
                        text: modelData.label
                        fontSize: 14
                        color: textColor
                    }
                    onClicked: modelData.onClick()
                }
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        cursorShape: Qt.PointingHandCursor
        onEntered: root.hovered = true
        onExited: {
            root.hovered = false;
        }
    }
}
