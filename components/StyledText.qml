import QtQuick
import qs.settings

Text {
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    font {
        hintingPreference: Font.PreferFullHinting
        family: Config.font.family.main ?? "sans-serif"
        pixelSize: 16
    }
    color: Config.color.fg ?? "white"
    linkColor: Config.color.primary
}
