pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

/**
 * A nice wrapper for date and time strings.
 */
Singleton {
    id: root
    property var clock: SystemClock {
        id: clock
        precision: {
            return SystemClock.Minutes;
        }
    }
    property QtObject date

    property string time: Qt.locale().toString(clock.date, "hh:mm")
    date: QtObject {
        property string day: Qt.locale().toString(clock.date, "dd")
        property string month: Qt.locale().toString(clock.date, "MM")
        property string weekDayShort: Qt.locale().toString(clock.date, "ddd")
        property string weekDayFull: Qt.locale().toString(clock.date, "dddd")
        property string shortDate: day + "/" + month
        property string fullDate: weekDayFull + ", " + shortDate
        property string collapsedCalendarFormat: Qt.locale().toString(clock.date, "dd MMMM yyyy")
    }
    property string uptime: "0h, 0m"

    Timer {
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            fileUptime.reload();
            const textUptime = fileUptime.text();
            const uptimeSeconds = Number(textUptime.split(" ")[0] ?? 0);

            // Convert seconds to days, hours, and minutes
            const days = Math.floor(uptimeSeconds / 86400);
            const hours = Math.floor((uptimeSeconds % 86400) / 3600);
            const minutes = Math.floor((uptimeSeconds % 3600) / 60);

            // Build the formatted uptime string
            let formatted = "";
            if (days > 0)
                formatted += `${days}d`;
            if (hours > 0)
                formatted += `${formatted ? ", " : ""}${hours}h`;
            if (minutes > 0 || !formatted)
                formatted += `${formatted ? ", " : ""}${minutes}m`;
            root.uptime = formatted;
            interval = 3000;
        }
    }

    FileView {
        id: fileUptime
        path: "/proc/uptime"
    }
}
