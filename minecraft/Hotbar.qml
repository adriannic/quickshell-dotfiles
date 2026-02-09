import Quickshell
import Quickshell.Hyprland
import QtQuick

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: root
        required property var modelData
        screen: modelData

        color: "transparent"

        anchors {
            bottom: true
            left: true
            right: true
        }

        implicitHeight: 22 * Settings.scale

        Image {
            id: leftSlot
            anchors {
                right: hotbar.left
                bottom: parent.bottom
                rightMargin: 7 * Settings.scale
            }
            source: "textures/slot-left"
            width: 22 * Settings.scale
            height: 22 * Settings.scale

            smooth: false
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: hotbar
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
            source: "textures/hotbar"
            width: 182 * Settings.scale
            height: 22 * Settings.scale

            smooth: false
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: selection
            property HyprlandWorkspace current: Hyprland.monitorFor(root.modelData).activeWorkspace
            anchors {
                left: leftSlot.left
                top: parent.top
                bottom: parent.bottom
                leftMargin: {
                    if (current && current.id <= 9) {
                        return (20 * (current.id - 1) + 29) * Settings.scale;
                    }

                    return 0;
                }
            }
            source: "textures/hotbar_selection"
            width: 22 * Settings.scale
            height: 22 * Settings.scale

            smooth: false
            fillMode: Image.PreserveAspectFit
        }

        PixelText {
            id: hours
            anchors {
                top: hotbar.top
                right: hotbar.right
                topMargin: 12 * Settings.scale
                rightMargin: (20 * 5 + 2) * Settings.scale + 1
            }
            scale: Settings.scale
            text: Time.hours
        }

        PixelText {
            id: minutes
            anchors {
                top: hotbar.top
                right: hotbar.right
                topMargin: 12 * Settings.scale
                rightMargin: (20 * 4 + 2) * Settings.scale + 1
            }
            scale: Settings.scale
            text: Time.minutes
        }

        PixelText {
            id: seconds
            anchors {
                top: hotbar.top
                right: hotbar.right
                topMargin: 12 * Settings.scale
                rightMargin: (20 * 3 + 2) * Settings.scale + 1
            }
            scale: Settings.scale
            text: Time.seconds
        }
    }
}
