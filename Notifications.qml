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

        onNotification: notification => {
            notification.tracked = true;
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: notifications
            required property ShellScreen modelData
            screen: modelData

            color: "transparent"

            anchors {
                right: true
                top: true
            }

            implicitWidth: 450
            implicitHeight: {
                let height = 0;
                for (const child of column.children) {
                    height += child.implicitHeight;
                }
                return height + Settings.spacing * (column.children.length + 5);
            }

            InvisibleContainer {
                anchors.fill: parent
                anchors.margins: Settings.spacing
                ColumnLayout {
                    id: column
                    anchors.fill: parent
                    Repeater {
                        model: notificationServer.trackedNotifications

                        Container {
                            id: notificationRoot
                            border.color: {
                                let urgency = notificationRoot.modelData.urgency;
                                if (urgency == 0) {
                                    return Colors.color8;
                                }

                                if (urgency == 2) {
                                    return Colors.color1;
                                }

                                return Colors.color2;
                            }
                            required property Notification modelData
                            Layout.fillWidth: true
                            implicitHeight: 128 + Settings.spacing * 2 + 2

                            x: 450

                            Component.onCompleted: {
                                x = 0;
                                notificationAlert.running = true;
                                notificationTimer.running = true;
                            }

                            Process {
                                id: notificationAlert
                                command: ["sh", "-c", "mpv --no-video ~/.config/audio/notification-mario.mp3"]
                            }

                            Timer {
                                id: notificationTimer
                                interval: Settings.notificationTime
                                running: false
                                onTriggered: if (notifications.modelData.name === Quickshell.screens[0].name) {
                                    notificationRoot.x = 450;
                                    notificationCloseTimer.running = true;
                                }
                            }

                            Timer {
                                id: notificationCloseTimer
                                interval: Settings.duration * 2
                                running: false
                                onTriggered: if (notifications.modelData.name === Quickshell.screens[0].name) {
                                    notificationRoot.modelData.dismiss();
                                }
                            }

                            Behavior on x {
                                PropertyAnimation {
                                    duration: Settings.duration * 2
                                    easing.type: Easing.InOutQuad
                                }
                            }

                            Behavior on y {
                                PropertyAnimation {
                                    duration: Settings.duration * 2
                                    easing.type: Easing.InOutQuad
                                }
                            }

                            ClippingRectangle {
                                id: imageWrapper
                                visible: notificationRoot.modelData.image
                                radius: 25
                                implicitWidth: image.paintedWidth
                                implicitHeight: image.paintedHeight
                                anchors {
                                    top: parent.top
                                    left: parent.left
                                    leftMargin: Settings.spacing + 1 + 64 - image.paintedWidth / 2
                                    topMargin: Settings.spacing + 1 + 64 - image.paintedHeight / 2
                                }
                                Image {
                                    id: image
                                    anchors.centerIn: parent
                                    source: notificationRoot.modelData.image
                                    sourceSize.width: 112
                                    sourceSize.height: 112
                                    width: 112
                                    height: 112
                                    fillMode: Image.PreserveAspectFit
                                }
                            }
                            InvisibleContainer {
                                id: textContainer
                                anchors {
                                    left: notificationRoot.modelData.image ? imageWrapper.right : parent.left
                                    right: parent.right
                                    top: parent.top
                                    bottom: parent.bottom
                                }

                                StyledText {
                                    id: summary
                                    anchors {
                                        top: parent.top
                                        left: parent.left
                                        right: parent.right
                                        leftMargin: Settings.spacing
                                        rightMargin: Settings.spacing
                                        topMargin: notificationRoot.modelData.image ? (textContainer.height - summary.height - body.height - Settings.spacing - 1) / 2 : 0
                                    }
                                    selected: false
                                    text: notificationRoot.modelData.summary
                                    wrapMode: Text.Wrap
                                    elide: Text.ElideRight
                                    maximumLineCount: 1
                                }
                                StyledText {
                                    id: body
                                    anchors {
                                        top: summary.bottom
                                        left: parent.left
                                        right: parent.right
                                        leftMargin: Settings.spacing
                                        rightMargin: Settings.spacing
                                    }
                                    selected: false
                                    text: notificationRoot.modelData.body
                                    wrapMode: Text.Wrap
                                    maximumLineCount: 5
                                    elide: Text.ElideRight
                                    font: Settings.subfont
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
