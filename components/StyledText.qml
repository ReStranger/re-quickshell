import QtQuick
import qs.config

Text {
    id: root
    property real fontSize
    property string fontColor: Theme.color.fg
    property int fontWeight: Font.Normal

    color: fontColor
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter

    font {
        hintingPreference: Font.PreferFullHinting
        family: Theme.font.family.main
        pixelSize: fontSize
        weight: fontWeight
    }
}
