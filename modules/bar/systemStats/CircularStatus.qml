import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config

StyledRectangle {
    id: root

    property real progress: 0
    property string text
    property string icon
    readonly property string foregroundColor: root.progress < 70 ? Theme.color.fg : root.progress < 85 ? Theme.color.orange : Theme.color.red

    implicitWidth: row.implicitWidth + 6
    implicitHeight: row.implicitHeight + 2
    RowLayout {
        id: row
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
        }

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
}
