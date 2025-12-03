pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import qs.utils

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

            root.uptime = Utils.formatSeconds(uptimeSeconds);
            interval = 3000;
        }
    }

    FileView {
        id: fileUptime
        path: "/proc/uptime"
    }
}
