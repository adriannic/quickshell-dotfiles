import Quickshell.Io
import QtQuick

Container {
    implicitWidth: 85
    Clickable {
        id: clickable
        anchors.fill: parent
        onReleased: {
            clock.activated = !clock.activated;
            pauseSound.running = true;
        }

        Process {
            id: pauseSound
            command: ["sh", "-c", "mpv --no-video --volume=60 ~/.config/audio/sonic/pause.wav"]
        }

        InvisibleContainer {
            id: container
            anchors.fill: parent
            anchors.margins: 0
            StyledText {
                id: clock
                property bool activated: false
                property bool showTime: activated ? clickable.containsMouse : !clickable.containsMouse

                text: showTime ? Time.time : Time.date
                selected: clickable.containsMouse
                anchors.centerIn: parent

                FadeBehavior on showTime {
                    fadeDuration: Settings.duration / 2
                }
            }
        }
    }
}
