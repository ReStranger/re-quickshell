import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config

RowLayout {
    id: root
    property real progress: 0
    property string text
    property string icon
    readonly property string foregroundColor: root.progress < 20 ? Theme.color.blue : Theme.cpuUsagePercent < 40 ? Theme.color.green : root.progress < 70 ? Theme.color.fg : root.progress < 85 ? Theme.color.orange : Theme.color.red

    Layout.leftMargin: 5

    CircularProgress {
        implicitWidth: 28
        implicitHeight: 28
        progress: root.progress
        icon: root.icon
        showProcentage: false
        foregroundColor: root.foregroundColor
    }

    StyledText {
        text: root.text && root.text.length > 0 ? root.text : (root.progress + "%")
        color: root.foregroundColor
        font.weight: Font.Bold
    }
}
