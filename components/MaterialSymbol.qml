import QtQuick
import qs.config

StyledText {
    id: root
    property real implicitSize: Theme?.font.pixelSize.small ?? 16
    property real fill: 0
    property real truncatedFill: fill.toFixed(1) // Reduce memory consumption spikes from constant font remapping
    property string icon

    text: icon
    renderType: fill !== 0 ? Text.CurveRendering : Text.NativeRendering

    font {
        family: Theme?.font.family.iconMaterial ?? "Material Symbols Rounded"
        pixelSize: implicitSize
        weight: Font.Normal + (Font.DemiBold - Font.Normal) * truncatedFill
        variableAxes: {
            "FILL": truncatedFill,
            "opsz": implicitSize
        }
    }
}
