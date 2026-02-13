import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config
import qs.services

Item {
    id: root
    visible: Battery.isLaptop

    implicitWidth: 60
    implicitHeight: 25

    property color batteryColor: {
        if (!Battery.onBattery) {
            return Theme.color.green;
        }
        if (Battery.percentage < 0.2) {
            return Theme.color.red;
        }
        return Theme.color.primary;
    }

    ClippingRectangle {
        id: background
        anchors.fill: parent
        radius: 100
        color: root.batteryColor

        RowLayout {
            id: textLayer
            anchors.centerIn: parent
            spacing: 0

            MaterialSymbol {
                visible: !Battery.onBattery
                icon: Battery.materialSymbol
                font.pixelSize: 14
                fill: 1
                color: "#000000"
                Layout.alignment: Qt.AlignHCenter
            }

            StyledText {
                id: batteryText
                text: Battery.batteryLvl + "%"
                font.pixelSize: 14
                font.weight: Font.Bold
                color: "#000000"
                font.bold: Battery.isLowBattery()
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
