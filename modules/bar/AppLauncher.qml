import QtQuick
import qs.components
import qs.config

StyledButton {
    id: root
    provider: Config.options.bar.launcher.isMaterial ? StyledButton.IconProvider.Material : StyledButton.IconProvider.System
    iconSize: 22
    icon.name: Config.options.bar.launcher.icon
}
