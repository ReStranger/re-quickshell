import qs.services
import qs.config

QSButton {
    visible: Config.options.qs.buttonEnable.powerProfile ? PowerProfile.havePowerProfileDeamon : false
    name: PowerProfile.statusText
    subName: "TestName"
    icon: PowerProfile.materialSymbol
    haveMenu: true
    toggled: PowerProfile.havePowerProfileDeamon

    onClicked: PowerProfile.nextProfile()
}
