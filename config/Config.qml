pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string filePath: Directories.shellConfigPath
    property alias options: configOptionsJsonAdapter
    property bool ready: false
    property int readWriteDelay: 50 // milliseconds

    function setNestedValue(nestedKey, value) {
        let keys = nestedKey.split(".");
        let obj = root.options;
        let parents = [obj];

        // Traverse and collect parent objects
        for (let i = 0; i < keys.length - 1; ++i) {
            if (!obj[keys[i]] || typeof obj[keys[i]] !== "object") {
                obj[keys[i]] = {};
            }
            obj = obj[keys[i]];
            parents.push(obj);
        }

        // Convert value to correct type using JSON.parse when safe
        let convertedValue = value;
        if (typeof value === "string") {
            let trimmed = value.trim();
            if (trimmed === "true" || trimmed === "false" || !isNaN(Number(trimmed))) {
                try {
                    convertedValue = JSON.parse(trimmed);
                } catch (e) {
                    convertedValue = value;
                }
            }
        }

        obj[keys[keys.length - 1]] = convertedValue;
    }

    Timer {
        id: fileReloadTimer
        interval: root.readWriteDelay
        repeat: false
        onTriggered: {
            configFileView.reload();
        }
    }

    Timer {
        id: fileWriteTimer
        interval: root.readWriteDelay
        repeat: false
        onTriggered: {
            configFileView.writeAdapter();
        }
    }

    FileView {
        id: configFileView
        path: root.filePath
        watchChanges: true
        onFileChanged: fileReloadTimer.restart()
        onAdapterUpdated: fileWriteTimer.restart()
        onLoaded: root.ready = true
        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                writeAdapter();
            }
        }

        JsonAdapter {
            id: configOptionsJsonAdapter
            property JsonObject system: JsonObject {
                property JsonObject user: JsonObject {
                    property string name: ""
                }
            }

            property JsonObject theme: JsonObject {
                property bool darkmode: true
                property bool showBackground: true
                property real blur: 0.11
                property bool flatButton: false
                property real rounding: 15
                property JsonObject lightColor: JsonObject {
                    property color primaryBg: "#121214"
                    property color secondaryBg: "#212126"
                    property color surfacePrimaryBg: "#2a2a30"
                    property color surfaceSecondaryBg: "#373740"
                    property color surfaceThirdBg: "#676778"
                    property color foreground: "#e9ecf2"
                    property color primary: "#f17ac6"
                    property color green: "#55b682"
                    property color blue: "#7aaaff"
                    property color orange: "#ff9c6a"
                    property color red: "#f25c5c"
                }
                property JsonObject darkColor: JsonObject {
                    property color primaryBg: "#121214"
                    property color secondaryBg: "#212126"
                    property color surfacePrimaryBg: "#2a2a30"
                    property color surfaceSecondaryBg: "#373740"
                    property color surfaceThirdBg: "#676778"
                    property color foreground: "#e9ecf2"
                    property color primary: "#f17ac6"
                    property color green: "#55b682"
                    property color blue: "#7aaaff"
                    property color orange: "#ff9c6a"
                    property color red: "#f25c5c"
                }
            }
            property JsonObject bar: JsonObject {
                property bool bottom: false // Instead of top
                property int cornerStyle: 0 // 0: Hug | 1: Float | 2: Plain rectangle
                property JsonObject launcher: JsonObject {
                    property bool isMaterial: false
                    property bool isMonochrome: false
                    property string icon: "nix-snowflake"
                }
            }
            property JsonObject battery: JsonObject {
                property int low: 20
                property int verylow: 10
                property int critical: 5
                property bool automaticSuspend: true
                property int suspend: 3
            }
            property JsonObject qs: JsonObject {
                property JsonObject buttonEnable: JsonObject {
                    property bool wifi: true
                    property bool bluetooth: true
                    property bool powerProfile: true
                    property bool dnd: true
                }
            }
        }
    }
}
