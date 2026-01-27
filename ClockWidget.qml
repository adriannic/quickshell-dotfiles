import QtQuick

Clickable {
    id: clickable
    onReleased: clock.activated = !clock.activated
    Container {
        id: container
        implicitWidth: 85
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
