pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

Singleton {
    readonly property string config: "/home/restranger/.config"

    property string shellConfig: `${Directories.config}/quickshell/main`
    property string shellConfigName: "config.json"
    property string shellConfigPath: `${Directories.shellConfig}/${Directories.shellConfigName}`
    property string avatarPath: `${Directories.shellConfig}/assets/avatar.png`
}
