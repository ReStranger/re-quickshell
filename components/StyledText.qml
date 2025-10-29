import QtQuick
import qs.config

Text {
    id: root
    property real fontSize
    property int fontWeight: Font.Normal
    property string fontColor: Theme.color.fg
    property string fontFamily: Theme.font.family.main

    color: fontColor
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter

    font {
        hintingPreference: Font.PreferFullHinting
        family: fontFamily
        pixelSize: fontSize
        weight: fontWeight
    }
}
