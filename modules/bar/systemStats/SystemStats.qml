import QtQuick
import QtQuick.Layouts
import qs.services

RowLayout {
    id: root

    CircularStatus {
        icon: "memory"
        progress: SystemInfo.cpuUsagePercent
    }
    CircularStatus {
        icon: "device_thermostat"
        progress: Math.max(0, Math.min(100, ((SystemInfo.cpuTemp - 10) / (110 - 10)) * 100))
        text: SystemInfo.cpuTemp + "°C"
    }
    CircularStatus {
        icon: "memory_alt"
        progress: SystemInfo.memoryUsagePercent
        text: SystemInfo.memoryUsage + " Gb"
    }
}
