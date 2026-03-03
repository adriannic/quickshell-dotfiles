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
        actionsSupported: false
        keepOnReload: false

        onNotification: notification => {
            notification.tracked = true;
        }
    }

    Variants {
        id: advancementVariant
        model: Quickshell.screens

        PanelWindow {
            id: advancementWindow
            required property var modelData
            screen: modelData

            exclusionMode: ExclusionMode.Ignore
            implicitWidth: 160 * Settings.scale
            mask: Region {
                width: advancementWindow.implicitWidth
                height: advancementList.implicitHeight
            }

            color: "transparent"

            anchors {
                top: true
                right: true
                bottom: true
            }

            Rectangle {
                id: advancementList
                anchors.left: parent.left
                anchors.right: parent.right

                implicitHeight: advancementColumn.childrenRect.height
                color: "transparent"

                Column {
                    id: advancementColumn
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: -1 * Settings.scale

                    Instantiator {
                        id: advancementInstantiator
                        model: notificationServer.trackedNotifications

                        delegate: Rectangle {
                            id: advancement

                            required property Notification modelData
                            required property int index

                            width: 160 * Settings.scale
                            height: 0
                            color: "transparent"

                            anchors.left: parent.left
                            anchors.leftMargin: advancementColumn.width

                            Component.onCompleted: {
                                height = Qt.binding(() => {
                                    let lineCount = advancementBody.lineCount + advancementSummary.lineCount;
                                    let h = (lineCount * 7 + 13) * Settings.scale;
                                    return Math.max(h, 32 * Settings.scale);
                                });

                                advancementGrowingTimer.start();
                            }

                            Timer {
                                id: advancementGrowingTimer
                                interval: 300
                                running: false
                                onTriggered: {
                                    advancement.anchors.leftMargin = 0;
                                }
                            }

                            Behavior on anchors.leftMargin {
                                NumberAnimation {
                                    duration: 500
                                    easing.type: Easing.InOutQuad
                                }
                            }

                            Behavior on height {
                                NumberAnimation {
                                    duration: 300
                                    easing.type: Easing.InOutQuad
                                }
                            }

                            Timer {
                                id: mainTimer
                                interval: 10500
                                running: true
                                onTriggered: {
                                    advancement.anchors.leftMargin = parent.width;
                                    closingAnimationTimer.running = true;
                                }
                            }

                            Timer {
                                id: closingAnimationTimer
                                interval: 500
                                running: false
                                onTriggered: {
                                    advancement.height = 0;
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
                                    advancement.anchors.leftMargin = parent.width;
                                    closingAnimationTimer.running = true;
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
                                width: parent.width
                                height: parent.height - 8 * Settings.scale
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
                                width: parent.width
                                height: 4 * Settings.scale
                                smooth: false
                            }

                            Image {
                                id: advancementIcon
                                visible: advancement.modelData.image
                                source: advancement.modelData.image || ""
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
                                text: advancement.modelData.summary || ""
                                isTitle: true
                                wrapMode: Text.Wrap
                                elide: Text.ElideRight
                                maximumLineCount: 1
                                anchors {
                                    right: parent.right
                                    left: advancementIcon.visible ? advancementIcon.right : parent.left
                                    top: parent.top
                                    topMargin: 6 * Settings.scale
                                    rightMargin: 5 * Settings.scale
                                    leftMargin: advancementIcon.visible ? 4 * Settings.scale : 6 * Settings.scale
                                }
                            }

                            PixelText {
                                id: advancementBody
                                scale: Settings.scale - 1
                                text: advancement.modelData.body || ""
                                wrapMode: Text.Wrap
                                maximumLineCount: 4
                                anchors {
                                    right: parent.right
                                    left: advancementIcon.visible ? advancementIcon.right : parent.left
                                    top: advancementSummary.bottom
                                    bottom: parent.bottom
                                    topMargin: 3 * Settings.scale
                                    bottomMargin: 6 * Settings.scale
                                    rightMargin: 5 * Settings.scale
                                    leftMargin: advancementIcon.visible ? 4 * Settings.scale : 6 * Settings.scale
                                }
                            }
                        }

                        onObjectAdded: (index, object) => {
                            object.parent = advancementColumn;
                        }

                        onObjectRemoved: (index, object) => {}
                    }
                }
            }
        }
    }
}
