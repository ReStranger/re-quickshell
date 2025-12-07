import qs.config

QSButton {
    visible: Config.options.qs.buttonEnable.dnd
    name: "DND"
    subName: "TestName"
    icon: GlobalStates.dndEnabled ? "notifications_off" : "notifications"
    toggled: GlobalStates.dndEnabled

    onClicked: GlobalStates.dndEnabled = !GlobalStates.dndEnabled
}
