import QtQuick
import qs.config

Text {
    id: root
    color: Theme.color.fg
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter

    font {
        hintingPreference: Font.PreferFullHinting
        pixelSize: 14
        family: Theme.font.family.main
        weight: Font.Normal
    }
}
