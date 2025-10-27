pragma Singleton

import Quickshell
import Quickshell.Services.UPower

/**
 * PowerProfile deamon wrapper
**/
Singleton {
    id: root
    property bool havePowerProfileDeamon: PowerProfiles.hasPerformanceProfile
    property string materialSymbol: switch (PowerProfiles.profile) {
    case PowerProfile.PowerSaver:
        return "energy_savings_leaf";
    case PowerProfile.Balanced:
        return "balance";
    case PowerProfile.Performance:
        return "local_fire_department";
    }
    property string statusText: switch (PowerProfiles.profile) {
    case PowerProfile.PowerSaver:
        return "Power Saver";
    case PowerProfile.Balanced:
        return "Balanced";
    case PowerProfile.Performance:
        return "Performance";
    }
    function nextProfile(event) {
        if (havePowerProfileDeamon) {
            switch (PowerProfiles.profile) {
            case PowerProfile.PowerSaver:
                PowerProfiles.profile = PowerProfile.Balanced;
                break;
            case PowerProfile.Balanced:
                PowerProfiles.profile = PowerProfile.Performance;
                break;
            case PowerProfile.Performance:
                PowerProfiles.profile = PowerProfile.PowerSaver;
                break;
            }
        } else {
            PowerProfiles.profile = PowerProfiles.profile == PowerProfile.Balanced ? PowerProfile.PowerSaver : PowerProfile.Balanced;
        }
    }
}
