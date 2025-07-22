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
    property QtObject time
    property QtObject date

    time: QtObject {
        property string hours: Qt.locale().toString(clock.date, "hh")
        property string minutes: Qt.locale().toString(clock.date, "mm")
        property string seconds: Qt.locale().toString(clock.date, "ss")
    }
    date: QtObject {
        property string weekDayFull: Qt.locale().toString(clock.date, "dddd")
        property string weekDayShort: Qt.locale().toString(clock.date, "ddd")
        property string day: Qt.locale().toString(clock.date, "dd")
        property string month: Qt.locale().toString(clock.date, "MM")
    }
    property string collapsedCalendarFormat: Qt.locale().toString(clock.date, "dd MMMM yyyy")
    property string uptime: "0h, 0m"

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

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
