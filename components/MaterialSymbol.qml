import QtQuick
import qs.config

Text {
    id: root
    property real iconSize: Theme?.font.pixelSize.small ?? 16
    property real fill: 0
    property real truncatedFill: fill.toFixed(1) // Reduce memory consumption spikes from constant font remapping
    property string icon

    text: icon
    renderType: fill !== 0 ? Text.CurveRendering : Text.NativeRendering
    verticalAlignment: Text.AlignVCenter

    font {
        hintingPreference: Font.PreferFullHinting
        family: Theme?.font.family.iconMaterial ?? "Material Symbols Rounded"
        pixelSize: iconSize
        weight: Font.Normal + (Font.DemiBold - Font.Normal) * truncatedFill
        variableAxes: {
            "FILL": truncatedFill,
            // "wght": font.weight,
            // "GRAD": 0,
            "opsz": iconSize
        }
    }
}
