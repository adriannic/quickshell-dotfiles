import Quickshell.Io
import Quickshell.Widgets
import QtQuick

WrapperMouseArea {
    id: mouseArea
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    hoverEnabled: true

    states: [
        State {
            name: "hovered"
            when: mouseArea.containsMouse
            PropertyChanges {
                target: child
                color: Colors.selectedBackground
            }
        },
        State {
            name: "default"
            when: !mouseArea.containsMouse
            PropertyChanges {
                target: child
                color: "transparent"
            }
        }
    ]

    onHoveredChanged: if (containsMouse) {
        selectSound.running = true;
    }

    Process {
        id: selectSound
        command: ["sh", "-c", "mpv --no-video --volume=60 ~/.config/audio/sonic/select.wav"]
    }
}
