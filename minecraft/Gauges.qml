pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Services.UPower
import QtQuick

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: root
        required property var modelData
        screen: modelData

        color: "transparent"

        exclusiveZone: 0
        aboveWindows: false

        margins.bottom: 3

        anchors {
            bottom: true
            left: true
            right: true
        }

        implicitHeight: 100

        Image {
            id: xpBarBg
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            source: "textures/experience_bar_background"
            width: 546
            height: 15

            smooth: false
            fillMode: Image.PreserveAspectFit
            Image {
                id: xpBar

                source: "textures/experience_bar_progress"
                width: 546 * Cpu.usage
                height: 15

                smooth: false
                fillMode: Image.PreserveAspectFit
                sourceClipRect: Qt.rect(0, 0, 182 * Cpu.usage, 5)
            }
        }

        PixelText {
            id: expNumber
            anchors {
                bottom: xpBarBg.top
                horizontalCenter: parent.horizontalCenter
                bottomMargin: -6
            }
            scale: 3
            text: Time.day
            isExp: true
        }

        Rectangle {
            id: hearts
            property int value: 17
            implicitWidth: 243
            implicitHeight: 27
            color: "transparent"
            anchors {
                bottom: xpBarBg.top
                left: xpBarBg.left
                bottomMargin: 3
            }
            Repeater {
                model: 10
                Image {
                    id: heartBase
                    required property int index

                    anchors {
                        left: hearts.left
                        leftMargin: 24 * index
                    }

                    source: "textures/container"
                    width: 27
                    height: 27
                    smooth: false
                    fillMode: Image.PreserveAspectFit
                }
            }
            Repeater {
                model: 10
                Image {
                    id: heart
                    required property int index

                    anchors {
                        left: hearts.left
                        leftMargin: 24 * index
                    }

                    visible: hearts.value > index * 2

                    source: {
                        if (hearts.value > index * 2 + 1) {
                            return "textures/full";
                        }
                        return "textures/half";
                    }
                    width: 27
                    height: 27
                    smooth: false
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Rectangle {
            id: foodBar
            property int value: 17
            implicitWidth: 243
            implicitHeight: 27
            color: "transparent"
            anchors {
                bottom: xpBarBg.top
                right: xpBarBg.right
                bottomMargin: 3
            }

            Repeater {
                model: 10
                Image {
                    id: food
                    required property int index

                    anchors {
                        right: foodBar.right
                        rightMargin: 24 * index
                    }

                    source: {
                        if (foodBar.value > index * 2 + 1) {
                            return "textures/food_full";
                        } else if (foodBar.value > index * 2) {
                            return "textures/food_half";
                        }
                        return "textures/food_empty";
                    }
                    width: 27
                    height: 27
                    smooth: false
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Rectangle {
            id: armorBar
            property int value: 17
            implicitWidth: 243
            implicitHeight: 27
            color: "transparent"
            anchors {
                bottom: hearts.top
                left: hearts.left
                bottomMargin: 3
            }

            Repeater {
                model: 10
                Image {
                    id: armor
                    required property int index

                    anchors {
                        left: armorBar.left
                        leftMargin: 24 * index
                    }

                    source: {
                        if (armorBar.value > index * 2 + 1) {
                            return "textures/armor_full";
                        }
                        if (armorBar.value > index * 2) {
                            return "textures/armor_half";
                        }
                        return "textures/armor_empty";
                    }
                    width: 27
                    height: 27
                    smooth: false
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Rectangle {
            id: airBar
            property int value: Math.round(UPower.displayDevice.percentage * 10)
            implicitWidth: 243
            implicitHeight: 27
            color: "transparent"
            visible: UPower.devices.values.length
            anchors {
                bottom: foodBar.top
                right: foodBar.right
                bottomMargin: 3
            }

            Repeater {
                model: 10
                Image {
                    id: air
                    required property int index

                    anchors {
                        right: airBar.right
                        rightMargin: 24 * index
                    }

                    source: {
                        if (airBar.value > index) {
                            return "textures/air";
                        }
                        return "textures/air_empty";
                    }
                    width: 27
                    height: 27
                    smooth: false
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
    }
}
