import QtQuick
import QtQuick.Layouts
import qs.services

RowLayout {
    id: root

    CircularStatus {
        icon: "memory"
        progress: System.cpuUsagePercent
    }
    CircularStatus {
        icon: "device_thermostat"
        progress: Math.max(0, Math.min(100, ((System.cpuTemp - 10) / (110 - 10)) * 100))
        text: System.cpuTemp + "°C"
    }
    CircularStatus {
        icon: "memory_alt"
        progress: System.memoryUsagePercent
        text: System.memoryUsage + " Gb"
    }
}
