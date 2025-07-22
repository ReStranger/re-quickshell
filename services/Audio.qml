pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root
    property var pwTracker: PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    property QtObject defaultSink: QtObject {
        property real volume: Pipewire.defaultAudioSink?.audio.muted ? 0 : Pipewire.defaultAudioSink?.audio.volume * 100

        property string icon: volume > 50 ? "volume_up" : volume > 0 ? "volume_down" : "volume_off"
    }
}
