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

        margins.bottom: Settings.scale

        anchors {
            bottom: true
            left: true
            right: true
        }

        implicitHeight: 25 * Settings.scale

        Image {
            id: xpBarBg
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            source: "textures/experience_bar_background"
            width: 182 * Settings.scale
            height: 5 * Settings.scale

            smooth: false
            fillMode: Image.PreserveAspectFit
            Image {
                id: xpBar

                source: "textures/experience_bar_progress"
                width: 182 * Settings.scale * Cpu.usage
                height: 5 * Settings.scale

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
                bottomMargin: -2 * Settings.scale
            }
            scale: Settings.scale
            text: Time.day
            isExp: true
        }

        Rectangle {
            id: hearts
            property int value: 17
            implicitWidth: 81 * Settings.scale
            implicitHeight: 9 * Settings.scale
            color: "transparent"
            anchors {
                bottom: xpBarBg.top
                left: xpBarBg.left
                bottomMargin: Settings.scale
            }
            Repeater {
                model: 10
                Image {
                    id: heartBase
                    required property int index

                    anchors {
                        left: hearts.left
                        leftMargin: 8 * Settings.scale * index
                    }

                    source: "textures/container"
                    width: 9 * Settings.scale
                    height: 9 * Settings.scale
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
                        leftMargin: 8 * Settings.scale * index
                    }

                    visible: hearts.value > index * 2

                    source: {
                        if (hearts.value > index * 2 + 1) {
                            return "textures/full";
                        }
                        return "textures/half";
                    }
                    width: 9 * Settings.scale
                    height: 9 * Settings.scale
                    smooth: false
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Rectangle {
            id: foodBar
            property int value: 17
            implicitWidth: 81 * Settings.scale
            implicitHeight: 9 * Settings.scale
            color: "transparent"
            anchors {
                bottom: xpBarBg.top
                right: xpBarBg.right
                bottomMargin: Settings.scale
            }

            Repeater {
                model: 10
                Image {
                    id: foodBase
                    required property int index

                    anchors {
                        right: foodBar.right
                        rightMargin: 8 * Settings.scale * index
                    }

                    source: "textures/food_empty"
                    width: 9 * Settings.scale
                    height: 9 * Settings.scale
                    smooth: false
                    fillMode: Image.PreserveAspectFit
                }
            }

            Repeater {
                model: 10
                Image {
                    id: food
                    required property int index

                    anchors {
                        right: foodBar.right
                        rightMargin: 8 * Settings.scale * index
                    }

                    visible: foodBar.value > index * 2

                    source: {
                        if (foodBar.value > index * 2 + 1) {
                            return "textures/food_full";
                        }
                        return "textures/food_half";
                    }
                    width: 9 * Settings.scale
                    height: 9 * Settings.scale
                    smooth: false
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Rectangle {
            id: armorBar
            property int value: 17
            implicitWidth: 81 * Settings.scale
            implicitHeight: 9 * Settings.scale
            color: "transparent"
            anchors {
                bottom: hearts.top
                left: hearts.left
                bottomMargin: Settings.scale
            }

            Repeater {
                model: 10
                Image {
                    id: armor
                    required property int index

                    anchors {
                        left: armorBar.left
                        leftMargin: 8 * Settings.scale * index
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
                    width: 9 * Settings.scale
                    height: 9 * Settings.scale
                    smooth: false
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Rectangle {
            id: airBar
            property int value: Math.round(UPower.displayDevice.percentage * 10)
            implicitWidth: 81 * Settings.scale
            implicitHeight: 9 * Settings.scale
            color: "transparent"
            visible: UPower.devices.values.length
            anchors {
                bottom: foodBar.top
                right: foodBar.right
                bottomMargin: Settings.scale
            }

            Repeater {
                model: 10
                Image {
                    id: air
                    required property int index

                    anchors {
                        right: airBar.right
                        rightMargin: 8 * Settings.scale * index
                    }

                    source: {
                        if (airBar.value > index) {
                            return "textures/air";
                        }
                        return "textures/air_empty";
                    }
                    width: 9 * Settings.scale
                    height: 9 * Settings.scale
                    smooth: false
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
    }
}
