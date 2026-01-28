import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Clickable {
    id: root
    required property QsMenuEntry modelData
    visible: !root.modelData.isSeparator
    enabled: root.modelData.enabled

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.leftMargin: 1
    Layout.rightMargin: 1

    onClicked: mouse => {
        root.modelData.triggered();
        mouse.accepted = false;
        confirmSound.running = true
    }

    Process {
        id: confirmSound
        command: ["sh", "-c", "mpv --no-video --volume=60 ~/.config/audio/sonic/confirm.wav"]
    }

    InvisibleContainer {
        id: container
        StyledText {
            id: text
            text: root.modelData.text
            selected: root.containsMouse
            color: root.containsMouse ? Colors.selectedForeground : root.modelData.hasChildren ? Colors.color2 : root.enabled ? Colors.foreground : Colors.color8
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Settings.spacing * 2
        }
    }
}
