import QtQuick
import qs.components
import qs.config

Item {
    id: root
    property real progress: 0
    property string icon: ""
    property real iconSize: 18
    property color foregroundColor: Theme.color.fg
    property color backgroundColor: Theme.color.sf01
    property bool useAnim: true
    property bool showProcentage: false
    property real strokeWidth: 3

    Behavior on progress {
        NumberAnimation {
            duration: root.useAnim ? 250 : 0
            easing.type: Easing.OutExpo
        }
    }
    onProgressChanged: canvas.requestPaint()
    Canvas {
        id: canvas
        anchors.fill: parent
        rotation: -90

        onPaint: {
            var ctx = getContext("2d");
            var centerX = width / 2;
            var centerY = height / 2;
            var radius = Math.min(centerX, centerY) - root.strokeWidth / 2;
            var startAngle = 0;
            var endAngle = (Math.PI * 2) * (root.progress / 100);

            ctx.reset();

            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
            ctx.lineWidth = root.strokeWidth;
            ctx.strokeStyle = root.backgroundColor;

            ctx.stroke();

            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, startAngle, endAngle);
            ctx.lineWidth = root.strokeWidth;
            ctx.strokeStyle = root.foregroundColor;
            ctx.lineCap = "round";
            ctx.stroke();
        }
    }
    MaterialSymbol {
        id: icon
        anchors.centerIn: parent
        icon: parent.icon
        color: root.foregroundColor
        iconSize: root.iconSize
        opacity: 1
        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }
    }

    StyledText {
        id: text
        anchors.centerIn: parent
        text: Math.round(parent.progress) + "%"
        color: Theme.color.primary
        font.pixelSize: root.iconSize
        opacity: 0
        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            if (!parent.showProcentage)
                return;
            icon.opacity = 0;
            text.opacity = 1;
        }
        onExited: {
            if (!parent.showProcentage)
                return;
            icon.opacity = 1;
            text.opacity = 0;
        }
    }
}
