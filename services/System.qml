pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

/**
 * System service that provides system info.
 */
Singleton {
    id: root

    property string username: ""

    property real cpuUsagePercent: 0
    property real cpuTemp: 0
    property real memoryUsagePercent: 0
    property real memoryUsage: 0

    property string currentGovernor: ""

    Process {
        id: usernameProcess
        command: ["sh", "-c", "echo $USER"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.username = this.text.trim()
        }
    }

    Process {
        id: cpuUsagePercent
        command: ["sh", "-c", `PREV=$(grep '^cpu ' /proc/stat); sleep 1; CURR=$(grep '^cpu ' /proc/stat); \
            PREV_TOTAL=$(echo $PREV | awk '{for(i=2;i<=NF;i++) total+=$i; print total}'); \
            PREV_IDLE=$(echo $PREV | awk '{print $5}'); \
            CURR_TOTAL=$(echo $CURR | awk '{for(i=2;i<=NF;i++) total+=$i; print total}'); \
            CURR_IDLE=$(echo $CURR | awk '{print $5}'); \
            DIFF_TOTAL=$((CURR_TOTAL - PREV_TOTAL)); DIFF_IDLE=$((CURR_IDLE - PREV_IDLE)); \
            echo $(( (100 * (DIFF_TOTAL - DIFF_IDLE) / DIFF_TOTAL) ))`]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.cpuUsagePercent = parseFloat(this.text.trim())
        }
    }

    Process {
        id: cpuTemp
        command: ["sh", "-c", "sensors | awk '/Tctl:/ {gsub(/[^0-9.]/,\"\",2); print $2}'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.cpuTemp = parseFloat(this.text.trim())
        }
    }

    Process {
        id: memoryUsageProcent
        command: ["sh", "-c", "free | awk '/Mem:/ {printf(\"%.0f\", $3/$2 * 100)}'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.memoryUsagePercent = parseFloat(this.text.trim())
        }
    }
    Process {
        id: memoryUsage
        command: ["sh", "-c", "free | awk '/Mem:/ {printf(\"%.2f\", $3/1024/1024)}'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.memoryUsage = parseFloat(this.text.trim())
        }
    }

    Process {
        id: currentGovernor
        command: ["sh", "-c", "cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.currentGovernor = this.text.trim()
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            cpuUsagePercent.running = true;
            cpuTemp.running = true;
            memoryUsageProcent.running = true;
            memoryUsage.running = true;
            currentGovernor.running = true;
        }
    }
}
