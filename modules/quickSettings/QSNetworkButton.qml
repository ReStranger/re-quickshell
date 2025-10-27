import qs.services
import qs.config

QSButton {
    visible: Config.options.qs.buttonEnable.wifi
    name: Network.ethernet ? "Connected" : (Network.wifi ? (Network.wifiEnabled ? "Enabled" : "Disabled") : "Not found")
    subName: Network.ethernet ? "Ethernet" : Network.networkName
    icon: Network.materialSymbol
    haveSubName: true
    haveMenu: Network.wifi
    toggled: Network.ethernet || (Network.wifi && Network.wifiEnabled)

    onClicked: if (Network.wifi) {
        Network.toggleWifi();
        toggled = !toggled;
    } else if (Network.ethernet) {}
}
