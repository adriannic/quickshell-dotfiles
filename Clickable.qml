import Quickshell.Widgets
import QtQuick

WrapperMouseArea {
    id: mouseArea
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    hoverEnabled: true

    states: State {
        name: "hovered"
        when: mouseArea.containsMouse
        PropertyChanges {
            target: child
            color: Colors.selectedBackground
        }
    }
}
