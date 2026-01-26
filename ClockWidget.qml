import QtQuick

Clickable {
    id: clickable
    onReleased: clock.showTime = !clock.showTime
    Container {
        id: container
        implicitWidth: 85
        Text {
            id: clock
            property bool showTime: true
            text: showTime ? Time.time : Time.date
            color: clickable.containsMouse ? Colors.selectedForeground : Colors.foreground
            font: Settings.font
            anchors.centerIn: parent

            Behavior on color {
                ColorAnimation {
                    duration: Settings.duration
                }
            }
            FadeBehavior on showTime {
                fadeDuration: Settings.duration / 2
            }
        }
    }
}
