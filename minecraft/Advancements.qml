pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

Scope {
    NotificationServer {
        id: notificationServer
        imageSupported: true
        bodyMarkupSupported: true
        actionsSupported: true
        keepOnReload: false

        onNotification: notification => {
            notification.tracked = true;
        }
    }

    Variants {
        id: advancementVariant
        model: Quickshell.screens

        Variants {
            id: advancementScreen
            required property ShellScreen modelData
            model: notificationServer.trackedNotifications.values
            readonly property int index: advancementVariant.instances.findIndex(elem => elem === this)

            PanelWindow {
                id: advancement
                required property Notification modelData
                readonly property int index: advancementScreen.instances.findIndex(elem => elem === this)
                screen: advancementScreen.modelData

                color: "transparent"

                implicitWidth: 160 * Settings.scale
                implicitHeight: {
                    let height = ((advancementBody.lineCount + advancementSummary.lineCount) * 7 + 13) * Settings.scale;
                    if (height < 32 * Settings.scale) {
                        height = 32 * Settings.scale;
                    }
                    return height;
                }
                exclusiveZone: 0

                anchors {
                    top: true
                    right: true
                }

                Behavior on implicitHeight {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                margins {
                    top: {
                        let height = 0;
                        for (let i = 0; i < index; ++i) {
                            height += advancementScreen.instances[i].implicitHeight;
                        }
                        return height;
                    }
                }

                Timer {
                    id: mainTimer
                    interval: 10500
                    running: true
                    onTriggered: {
                        container.anchors.leftMargin = parent.width;
                        container.anchors.rightMargin = -parent.width;
                        closingAnimationTimer.running = true;
                    }
                }

                Timer {
                    id: closingAnimationTimer
                    interval: 500
                    running: false
                    onTriggered: {
                        advancement.implicitHeight = 0;
                        if (advancementScreen.index === 0)
                            advancementShrinkingTimer.running = true;
                    }
                }

                Timer {
                    id: advancementShrinkingTimer
                    interval: 500
                    running: false
                    onTriggered: {
                        advancement.modelData.dismiss();
                    }
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        container.anchors.leftMargin = parent.width;
                        container.anchors.rightMargin = -parent.width;
                        closingAnimationTimer.running = true;
                    }
                }

                Rectangle {
                    id: container
                    anchors.fill: parent
                    color: "transparent"
                    anchors.leftMargin: parent.width
                    anchors.rightMargin: -parent.width

                    Component.onCompleted: {
                        anchors.leftMargin = 0;
                        anchors.rightMargin = 0;
                    }

                    Behavior on anchors.leftMargin {
                        NumberAnimation {
                            duration: 500
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on anchors.rightMargin {
                        NumberAnimation {
                            duration: 500
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Image {
                        id: advancementBgTop
                        anchors {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        source: "textures/advancement_top"
                        height: 4 * Settings.scale

                        smooth: false
                    }

                    Image {
                        id: advancementBgMiddle
                        anchors {
                            top: advancementBgTop.bottom
                            bottom: advancementBgBottom.top
                            left: parent.left
                            right: parent.right
                        }
                        source: "textures/advancement_middle"
                        width: parent.implicitWidth
                        height: parent.implicitHeight - 8 * Settings.scale

                        smooth: false
                    }

                    Image {
                        id: advancementBgBottom
                        anchors {
                            bottom: parent.bottom
                            left: parent.left
                            right: parent.right
                        }
                        source: "textures/advancement_bottom"
                        width: parent.implicitWidth
                        height: 4 * Settings.scale

                        smooth: false
                    }

                    Image {
                        id: advancementIcon
                        visible: advancement.modelData.image
                        source: advancement.modelData.image
                        width: 20 * Settings.scale
                        height: 20 * Settings.scale

                        anchors {
                            top: parent.top
                            left: parent.left
                            topMargin: 6 * Settings.scale
                            leftMargin: 6 * Settings.scale
                        }
                        fillMode: Image.PreserveAspectFit
                    }

                    PixelText {
                        id: advancementSummary
                        scale: Settings.scale - 1
                        text: advancement.modelData.summary
                        isTitle: true
                        wrapMode: Text.Wrap
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        anchors {
                            right: parent.right
                            left: advancementIcon.visible ? advancementIcon.right : advancementIcon.left
                            top: parent.top
                            topMargin: 6 * Settings.scale
                            rightMargin: 5 * Settings.scale
                            leftMargin: advancementIcon.visible ? 4 * Settings.scale : 0
                        }
                    }

                    PixelText {
                        id: advancementBody
                        scale: Settings.scale - 1
                        text: advancement.modelData.body
                        wrapMode: Text.Wrap
                        maximumLineCount: 8
                        anchors {
                            right: parent.right
                            left: advancementIcon.visible ? advancementIcon.right : advancementIcon.left
                            top: advancementSummary.bottom
                            bottom: parent.bottom
                            topMargin: 3 * Settings.scale
                            bottomMargin: 6 * Settings.scale
                            rightMargin: 5 * Settings.scale
                            leftMargin: advancementIcon.visible ? 4 * Settings.scale : 0
                        }
                    }
                }
            }
        }
    }
}
