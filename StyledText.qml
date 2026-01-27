import QtQuick

Text {
    font: Settings.font
    required property bool selected
    color: selected ? Colors.selectedForeground : Colors.foreground
    Behavior on color {
        ColorAnimation {
            duration: Settings.duration
        }
    }
}
