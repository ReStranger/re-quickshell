pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services
import qs.config

StyledButton {
    id: root
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    toggled: GlobalStates.qsOpen

    property color textColor: root.enabled ? ((root.toggled || root.pressed) ? Theme.color.bg00 : Theme.color.fg) : Theme.color.sf01

    onClicked: function (mouse) {
        if (mouse.button === Qt.LeftButton) {
            GlobalStates.qsOpen = !GlobalStates.qsOpen;
        }
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }
    Behavior on implicitHeight {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    contentItem: RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 2

        Item {
            implicitWidth: 1
        }
        MaterialSymbol {
            id: dndIcon
            visible: GlobalStates.dndEnabled
            icon: GlobalStates.dndEnabled ? "notifications_off" : ""
            color: root.textColor
            font.pixelSize: 18
        }
        MaterialSymbol {
            id: networkIcon
            icon: Network.materialSymbol
            color: root.textColor
            font.pixelSize: 18
        }
        MaterialSymbol {
            id: sourceMuteIcon
            visible: Audio.source.volume === 0
            icon: Audio.source.materialSymbol
            color: root.textColor
            font.pixelSize: 18
        }
        MaterialSymbol {
            id: sinkMuteIcon
            icon: Audio.sink.materialSymbol
            color: root.textColor
            font.pixelSize: 18
        }
        MaterialSymbol {
            id: bluetoothIcon
            visible: Bluetooth.available
            icon: Bluetooth.materialSymbol
            color: root.textColor
            font.pixelSize: 18
        }
        MaterialSymbol {
            id: powerProfileIcon
            visible: PowerProfile.havePowerProfileDeamon && PowerProfile.statusText !== "Balanced"
            icon: PowerProfile.havePowerProfileDeamon ? PowerProfile.materialSymbol : ""
            color: root.textColor
            font.pixelSize: 18
        }
        Item {
            implicitWidth: 1
        }
    }
}
