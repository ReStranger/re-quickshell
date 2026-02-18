import QtQuick

QtObject {
    required property var lastIpcObject
    readonly property string ssid: lastIpcObject.ssid
    readonly property string bssid: lastIpcObject.bssid
    readonly property int strength: lastIpcObject.strength
    readonly property int frequency: lastIpcObject.frequency
    readonly property bool active: lastIpcObject.active
    readonly property string security: lastIpcObject.security
    readonly property bool isSecure: security.length > 0
    readonly property string materialSymbol: strength > 83 ? "signal_wifi_4_bar" : strength > 67 ? "network_wifi" : strength > 50 ? "network_wifi_3_bar" : strength > 33 ? "network_wifi_2_bar" : strength > 17 ? "network_wifi_1_bar" : "signal_wifi_0_bar"

    property bool askingPassword: false
}
