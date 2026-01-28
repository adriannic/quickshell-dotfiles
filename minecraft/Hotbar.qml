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

        implicitHeight: 69

        Image {
            id: leftSlot
            anchors {
                right: hotbar.left
                bottom: parent.bottom
                rightMargin: 21
            }
            source: "textures/slot-left"
            width: 66
            height: 66

            smooth: false
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: hotbar
            anchors {
                right: parent.right
                bottom: parent.bottom
                rightMargin: 687
            }
            source: "textures/hotbar"
            width: 546
            height: 66

            smooth: false
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: selection
            property HyprlandWorkspace current: Hyprland.monitorFor(root.modelData).activeWorkspace
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                leftMargin: {
                    if (current && current.id <= 9) {
                        return 684 + 60 * (current.id - 1);
                    }

                    return 597
                }
            }
            source: "textures/hotbar_selection"
            width: 72
            height: 69

            smooth: false
            fillMode: Image.PreserveAspectFit
        }

        PixelText {
            id: hours
            anchors {
                top: hotbar.top
                right: hotbar.right
                topMargin: 36
                rightMargin: 6 + 60 * 5
            }
            scale: 3
            text: Time.hours
        }

        PixelText {
            id: minutes
            anchors {
                top: hotbar.top
                right: hotbar.right
                topMargin: 36
                rightMargin: 6 + 60 * 4
            }
            scale: 3
            text: Time.minutes
        }

        PixelText {
            id: seconds
            anchors {
                top: hotbar.top
                right: hotbar.right
                topMargin: 36
                rightMargin: 6 + 60 * 3
            }
            scale: 3
            text: Time.seconds
        }
    }
}
