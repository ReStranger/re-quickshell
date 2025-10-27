import qs.services
import qs.config

QSButton {
    visible: Config.options.qs.buttonEnable.bluetooth
    name: Bluetooth.available ? "Powered" : "Disabled"
    subName: Bluetooth.available ? "Not connected" : "No adapter" // TODO: Add connected device name
    icon: Bluetooth.materialSymbol
    haveSubName: true
    haveMenu: true
    toggled: Bluetooth.enabled
    // onClicked: } // TODO: Add power on/off function
}
