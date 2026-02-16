import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import qs.components
import qs.config

Item {
    id: root

    property string title: "No app"
    property string body: "No content"
    property var rawNotification: null
    property bool tracked: false
    property string image: ""
    property bool showButtons: mouseHandler.containsMouse && root.buttons.length > 1

    property var buttons: []
    property alias border: background.border

    signal entered
    signal exited

    function dismiss() {
        root.rawNotification?.notification.dismiss();
    }

    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    // WindowShadow {
    //     target: background
    // }
    Rectangle {
        id: background

        color: Theme.color.bg00
        implicitWidth: 300
        implicitHeight: content.implicitHeight + 20
        radius: Theme.rounding.windowRounding

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton

            onClicked: {
                root.buttons[0].onClick();
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
                            clip: true
                            text: root.title.length > 23 ? root.title.substr(0, 20) + "..." : root.title
                            font.pixelSize: 16
                            font.weight: Font.Bold
                            color: Theme.color.fg

                            Layout.fillWidth: true
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
                        text: modelData.label
                        font.pixelSize: 14
                        onClicked: modelData?.onClick()
                    }
                }
            }
        }
        MouseArea {
            id: mouseHandler
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.NoButton
            cursorShape: Qt.PointingHandCursor
        }
        MouseArea {
            id: closeButtonArea

            anchors {
                top: parent.top
                right: parent.right
                topMargin: 5
                rightMargin: 6
            }
            cursorShape: Qt.PointingHandCursor
            implicitWidth: closeButton.implicitWidth
            implicitHeight: closeButton.implicitHeight

            onClicked: root.dismiss()

            MaterialSymbol {
                id: closeButton
                anchors.centerIn: parent
                icon: "close"
                font.pixelSize: 22
                color: Theme.color.fg
                opacity: mouseHandler.containsMouse ? 90 : 0

                rotation: mouseHandler.containsMouse ? 90 : 0
                transformOrigin: Item.Center

                Behavior on rotation {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on opacity {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }
}
