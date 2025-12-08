pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.config
import qs.utils

Singleton {
    id: root
    property int notifiedLevel: -1

    readonly property var batteries: UPower.devices.values.filter(device => device.isLaptopBattery)
    readonly property bool onBattery: UPower.onBattery
    readonly property real percentage: UPower.displayDevice.percentage

    readonly property bool isLaptop: UPower.displayDevice.isLaptopBattery
    
    readonly property int batteryLvl: batteries.length > 0 ? Math.round(root.percentage * 100) : 0
    

    readonly property string materialSymbol: !root.onBattery ? "bolt" : ""

    readonly property string chargingInfo: {
        let output = "";
        if (root.onBattery)
            output += Utils.formatSeconds(UPower.displayDevice.timeToEmpty) || "Calculating";
        else
            output += Utils.formatSeconds(UPower.displayDevice.timeToFull) || "Fully charged";

        return output;
    }

    function isLowBattery() {
        return root.batteryLvl < Config.options.battery.low;
    }

    Connections {
        target: root
        function onBatteryLvlChanged() { 
            if (!root.onBattery) {
                root.notifiedLevel = -1;
                return;
            }

            if (root.batteryLvl === root.notifiedLevel)
                return;

            if (root.batteryLvl <= Config.options.battery.critical && root.notifiedLevel > Config.options.battery.critical) {
                root.notifiedLevel = Config.options.battery.critical;
                Quickshell.execDetached({
                    command: ["sh", "-c", "notify-send", "--urgency=critical", "Battery critically low", "Emergency shutdown imminent unless plugged in."]
                });
            } else if (root.batteryLvl <= Config.options.battery.verylow && root.notifiedLevel > Config.options.battery.verylow) {
                root.notifiedLevel = Config.options.battery.verylow;
                Quickshell.execDetached({
                    command: ["sh", "-c", "notify-send", "--urgency=critical", "Battery very low", "Please plug in your charger now."]
                });
            } else if (root.batteryLvl <= Config.options.battery.low && root.notifiedLevel > Config.options.battery.low) {
                root.notifiedLevel = Config.options.battery.low;
                Quickshell.execDetached({
                    command: ["sh", "-c", "notify-send", "--urgency=critical", "Low battery", "Consider plugging in your charger."]
                });
            }
        }
    }
}
