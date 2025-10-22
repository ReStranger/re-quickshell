import QtQuick
import qs.utils
import qs.config

Item {
    id: root
    property color fillColor: ColorUtils.transparentize(Theme.color.fg, 94 / 100)
    property color borderColor: ColorUtils.transparentize("#eeeeee", 94 / 100)
    //

    property int borderWidth: 1
    property int radius: Theme.rounding.windowRounding / 1.2

    anchors.fill: parent
    onFillColorChanged: canvas.requestPaint()
    onBorderColorChanged: canvas.requestPaint()
    onBorderWidthChanged: canvas.requestPaint()
    onRadiusChanged: canvas.requestPaint()
    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            ctx.save();
            ctx.beginPath();
            ctx.moveTo(root.radius, 0);
            ctx.lineTo(width - root.radius, 0);
            ctx.arcTo(width, 0, width, root.radius, root.radius);
            ctx.lineTo(width, height - root.radius);
            ctx.arcTo(width, height, width - root.radius, height, root.radius);
            ctx.lineTo(root.radius, height);
            ctx.arcTo(0, height, 0, height - root.radius, root.radius);
            ctx.lineTo(0, root.radius);
            ctx.arcTo(0, 0, root.radius, 0, root.radius);
            ctx.closePath();
            ctx.fillStyle = root.fillColor;
            ctx.fill();
            ctx.restore();

            ctx.save();
            ctx.beginPath();
            var inset = root.borderWidth / 2;
            ctx.moveTo(inset + root.radius, inset);
            ctx.lineTo(width - inset - root.radius, inset);
            ctx.arcTo(width - inset, inset, width - inset, inset + root.radius, root.radius);
            ctx.lineTo(width - inset, height - inset - root.radius);
            ctx.arcTo(width - inset, height - inset, width - inset - root.radius, height - inset, root.radius);
            ctx.lineTo(inset + root.radius, height - inset);
            ctx.arcTo(inset, height - inset, inset, height - inset - root.radius, root.radius);
            ctx.lineTo(inset, inset + root.radius);
            ctx.arcTo(inset, inset, inset + root.radius, inset, root.radius);
            ctx.closePath();

            ctx.strokeStyle = root.borderColor;
            ctx.lineWidth = root.borderWidth;
            ctx.stroke();
            ctx.restore();
        }
    }
}
