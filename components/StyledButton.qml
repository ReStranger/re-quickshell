import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.utils

Button {
    id: root
    horizontalPadding: 8
    verticalPadding: 6
    implicitHeight: contentItem.implicitHeight + verticalPadding * 2
    implicitWidth: contentItem.implicitWidth + horizontalPadding * 2

    enum IconProvider {
        System,
        Material,
        NerdFont
    }
    property alias radius: background.radius
    property alias topLeftRadius: background.topLeftRadius
    property alias topRightRadius: background.topRightRadius
    property alias bottomLeftRadius: background.bottomLeftRadius
    property alias bottomRightRadius: background.bottomRightRadius
    property alias border: background.border
    property alias horizontalAlignment: buttonText.horizontalAlignment
    property alias buttonSpacing: contentLayout.spacing
    property alias backgroundOpacity: background.opacity

    property var provider: StyledButton.IconProvider.System

    property real iconSize: 16
    property color bgColor: ColorUtils.transparentize("#eeeeee", 0.94)
    property color bgColorHover: ColorUtils.transparentize("#eeeeee", 0.85)
    property color bgColorActive: ColorUtils.transparentize("#eeeeee", 0.75)
    property color fgColor: "#eeeeee"
    property color fgColorActive: "#eeeeee"
    property color fgColorDisable: "#373740"
    property color backgroundColor: {
        if (!root.enabled)
            return bgColor;
        if (root.pressed) {
            return root.bgColorActive;
        } else if (root.down || root.checked) {
            return root.bgColorHover;
        } else if (root.hovered) {
            return root.bgColorHover;
        } else {
            return root.bgColor;
        }
    }
    property color foregroundColor: {
        if (!root.enabled)
            return root.fgColorDisable;
        if (root.pressed) {
            return root.fgColorActive;
        } else {
            return root.fgColor;
        }
    }

    property var altAction: () => {}
    property var middleClickAction: () => {}

    Behavior on backgroundColor {
        ColorAnimation {
            duration: 100
        }
    }
    Behavior on foregroundColor {
        ColorAnimation {
            duration: 100
        }
    }

    background: StyledRectangle {
        id: background
        color: root.backgroundColor
    }
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                root.clicked();
            }
            if (mouse.button === Qt.RightButton)
                root.altAction();
            if (mouse.button === Qt.MiddleButton)
                root.middleClickAction();
        }
    }
    contentItem: Item {
        implicitWidth: contentLayout.implicitWidth
        implicitHeight: contentLayout.implicitHeight
        RowLayout {
            id: contentLayout
            anchors {
                centerIn: parent
                leftMargin: root.horizontalPadding
                rightMargin: root.horizontalPadding
            }
            spacing: 5
            StyledIcon {
                implicitSize: root.iconSize
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignVCenter
                icon: root.icon.name
                visible: root.icon.name !== "" && root.provider === StyledButton.IconProvider.System
            }
            MaterialSymbol {
                implicitSize: root.iconSize
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignVCenter
                icon: root.icon.name
                color: root.foregroundColor
                visible: root.icon.name !== "" && root.provider === StyledButton.IconProvider.Material
            }
            StyledText {
                id: buttonText
                visible: root.text !== ""
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font: root.font
                text: root.text
                color: root.foregroundColor
            }
        }
    }
}
