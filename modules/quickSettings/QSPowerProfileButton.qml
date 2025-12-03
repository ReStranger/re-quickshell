import qs.services
import qs.config
import qs.utils

QSButton {
    visible: Config.options.qs.buttonEnable.powerProfile
    name: PowerProfile.havePowerProfileDeamon ? PowerProfile.statusText : Utils.capitalize(System.currentGovernor)
    icon: PowerProfile.havePowerProfileDeamon ? PowerProfile.materialSymbol : "speed"
    haveMenu: PowerProfile.havePowerProfileDeamon
    toggled: PowerProfile.havePowerProfileDeamon

    onClicked: {
        if (PowerProfile.havePowerProfileDeamon)
            PowerProfile.nextProfile();
    }
}
