pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSource, Pipewire.defaultAudioSink, Pipewire.nodes, Pipewire.links]
    }

    component AudioBus: QtObject {
        required property bool isSink
        required property var activeNode

        readonly property var list: Pipewire.nodes.values.filter(node => node.isSink === isSink && !node.isStream && node.audio)

        readonly property real volume: activeNode?.audio?.volume ?? 0
        readonly property bool muted: activeNode?.audio?.muted ?? false

        readonly property string materialSymbol: (muted || volume <= 0) ? (isSink ? "volume_off" : "mic_off") : (isSink ? (volume > 0.5 ? "volume_up" : "volume_down") : "mic")

        function setVolume(to: real): void {
            if (activeNode?.ready && activeNode?.audio) {
                activeNode.audio.muted = false;
                activeNode.audio.volume = Math.max(0, Math.min(1, to));
            }
        }

        function setDefault(node: PwNode): void {
            if (isSink)
                Pipewire.preferredDefaultAudioSink = node;
            else
                Pipewire.preferredDefaultAudioSource = node;
        }
    }

    property AudioBus sink: AudioBus {
        isSink: true
        activeNode: Pipewire.defaultAudioSink
    }

    property AudioBus source: AudioBus {
        isSink: false
        activeNode: Pipewire.defaultAudioSource
    }
}
