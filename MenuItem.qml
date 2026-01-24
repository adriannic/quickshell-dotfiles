import Quickshell
import QtQuick
import QtQuick.Layouts

Clickable {
    id: root
    required property QsMenuEntry modelData
    visible: !root.modelData.isSeparator
    enabled: root.modelData.enabled

    Layout.preferredHeight: text.contentHeight + Settings.spacing * 2
    Layout.leftMargin: 1
    Layout.rightMargin: 1

    onClicked: mouse => {
        root.modelData.triggered();
        mouse.accepted = false;
    }

    Container {
        Layout.preferredWidth: text.contentWidth + Settings.spacing * 4
        border.width: 0

        Text {
            id: text
            text: root.modelData.text
            font: Settings.font
            color: {
                root.containsMouse ? Colors.background : root.modelData.hasChildren ? Colors.color2 : root.enabled ? Colors.foreground : Colors.color8;
            }
            anchors.centerIn: parent

            Behavior on color {
                ColorAnimation {
                    duration: Settings.duration
                }
            }
        }
    }
}
