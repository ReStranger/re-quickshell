pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services
import qs.config

StyledButton {
    id: root
    // acceptedButtons: Qt.LeftButton | Qt.RightButton
    checked: GlobalStates.qsOpen

    onClicked: GlobalStates.qsOpen = !GlobalStates.qsOpen

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
        // anchors.centerIn: parent
        spacing: 2

        // Item {
        //     implicitWidth: 1
        // }
        MaterialSymbol {
            id: dndIcon
            visible: GlobalStates.dndEnabled
            icon: GlobalStates.dndEnabled ? "notifications_off" : ""
            color: root.foregroundColor
            font.pixelSize: 18
        }
        MaterialSymbol {
            id: networkIcon
            icon: Network.materialSymbol
            color: root.foregroundColor
            font.pixelSize: 18
        }
        MaterialSymbol {
            id: sourceMuteIcon
            visible: Audio.source.volume === 0
            icon: Audio.source.materialSymbol
            color: root.foregroundColor
            font.pixelSize: 18
        }
        MaterialSymbol {
            id: sinkMuteIcon
            icon: Audio.sink.materialSymbol
            color: root.foregroundColor
            font.pixelSize: 18
        }
        MaterialSymbol {
            id: bluetoothIcon
            visible: Bluetooth.available
            icon: Bluetooth.materialSymbol
            color: root.foregroundColor
            font.pixelSize: 18
        }
        MaterialSymbol {
            id: powerProfileIcon
            visible: PowerProfile.havePowerProfileDeamon && PowerProfile.statusText !== "Balanced"
            icon: PowerProfile.havePowerProfileDeamon ? PowerProfile.materialSymbol : ""
            color: root.foregroundColor
            font.pixelSize: 18
        }
    }
}
