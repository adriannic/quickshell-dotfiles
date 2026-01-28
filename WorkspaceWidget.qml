pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Container {
    id: root
    property ShellScreen screen
    property HyprlandWorkspace current: Hyprland.monitorFor(screen).activeWorkspace

    onCurrentChanged: Hyprland.refreshMonitors()

    RowLayout {
        anchors.fill: parent
        spacing: 0
        anchors.margins: 1

        Repeater {
            model: Settings.workspaces

            Clickable {
                id: clickable
                required property int modelData
                Layout.fillWidth: true
                Layout.fillHeight: true
                implicitWidth: 30

                onHoveredChanged: if (containsMouse) {
                    indicator.hovered = modelData;
                } else if (indicator.hovered === modelData) {
                    indicator.hovered = -1;
                }

                onClicked: Hyprland.dispatch(`focusworkspaceoncurrentmonitor ${modelData}`)
                Container {
                    id: container
                    border.width: 0
                    StyledText {
                        anchors.centerIn: parent
                        text: `${clickable.modelData}`
                        selected: clickable.containsMouse
                    }
                }
            }
        }
    }

    Rectangle {
        id: indicator
        property int hovered: -1
        implicitWidth: 22
        implicitHeight: 2
        x: 8 + 34 * ((root.current ? root.current.id : 9) - 1)
        y: 26
        color: (root.current ? root.current.id : 9) > 9 ? "transparent" : hovered === (root.current ? root.current.id : 9) ? Colors.selectedForeground : Colors.foreground

        Behavior on color {
            ColorAnimation {
                duration: Settings.duration
            }
        }

        Behavior on x {
            NumberAnimation {
                duration: Settings.duration
                easing.type: Easing.InOutQuad
            }
        }
    }
}
