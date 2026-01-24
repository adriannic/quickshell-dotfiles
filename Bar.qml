import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            required property var modelData
            screen: modelData

            color: "transparent"

            anchors {
                bottom: true
                left: true
                right: true
            }

            implicitHeight: 36

            WrapperItem {
                id: barMargin
                margin: 4
                topMargin: 0
                anchors.fill: parent
                Rectangle {
                    id: barBackground
                    color: "transparent"

                    RowLayout {
                        id: barLayout
                        anchors.fill: parent
                        spacing: 4

                        RowLayout {
                            id: barStart
                            spacing: 4
                            Layout.alignment: Qt.AlignLeft

                            WorkspaceWidget {
                                Layout.fillHeight: true
                                screen: bar.modelData
                            }
                        }

                        RowLayout {
                            id: barCenter
                            spacing: 4
                            Layout.alignment: Qt.AlignHCenter

                            Item {
                                Layout.fillWidth: true
                            }
                        }

                        RowLayout {
                            id: barEnd
                            spacing: 4
                            Layout.alignment: Qt.AlignRight

                            TrayWidget {
                                Layout.fillHeight: true
                            }
                            ClockWidget {
                                Layout.fillHeight: true
                            }
                        }
                    }
                }
            }
        }
    }
}
