import qs.config

QSButton {
    visible: Config.options.qs.buttonEnable.dnd
    name: GlobalStates.dndEnabled ? "Silent" : "DND"
    icon: GlobalStates.dndEnabled ? "notifications_off" : "notifications"
    toggled: GlobalStates.dndEnabled

    onClicked: GlobalStates.dndEnabled = !GlobalStates.dndEnabled
}
