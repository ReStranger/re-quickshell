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
    property bool popup: false
    property string image: ""
    // TODO:
    property bool hovered: false

    property var buttons: [
        {
            label: "Okay!",
            onClick: () => console.log("Okay")
        },
        {
            label: "Okay!",
            onClick: () => console.log("Okay")
        }
    ]

    signal entered
    signal exited

    function dismiss() {
        root.rawNotification?.notification.dismiss();
        console.log("^^^ | NotificationItem dismiss");
    }

    color: Theme.color.bg00
    implicitWidth: 300
    implicitHeight: content.implicitHeight + 20
    radius: 15
    RowLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10
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
            RowLayout {
                // TODO: Add revealer on haver
                visible: root.buttons.length > 1 && false
                spacing: 10

                Layout.fillWidth: true
                Layout.preferredHeight: 25

                Repeater {
                    Layout.fillWidth: true
                    model: root.buttons

                    StyledButton {
                        Layout.fillWidth: true
                        implicitHeight: 25
                        implicitWidth: 0
                        contentItem: StyledText {
                            text: modelData.label
                            fontSize: 12
                        }
                        onClicked: modelData.onClick()
                    }
                }
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        acceptedButtons: Qt.NoButton
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            modelData.onClick()
            console.log(modelData.label)
            root.dismiss()
        }
        onExited: {
            if (root.popup) {
                root.dismiss();
            }
        }
    }
}
