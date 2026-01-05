import QtQuick
import qs.components
import qs.config

StyledIconButton {
    id: root
    material: Config.options.bar.launcher.isMaterial
    iconSize: 22
    iconName: Config.options.bar.launcher.icon
}
