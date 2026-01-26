import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

Clickable {
    id: root
    required property SystemTrayItem modelData

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.margins: 1

    onClicked: event => {
        if (event.button === Qt.LeftButton) {
            popupMenu.visible = !popupMenu.visible;
            grab.active = !grab.active;
            console.log("left");
        } else {
            modelData.secondaryActivate();
            console.log("right");
        }
    }

    Container {
        id: container
        border.color: "transparent"
        color: "transparent"
        IconImage {
            anchors.fill: parent
            anchors.margins: {
                right: Settings.spacing * 1.5;
            }
            source: {
                let icon = root.modelData.icon;
                if (icon.includes("?")) {
                    let path = icon.split("?")[1].split("=")[1];
                    let iconName = icon.split("?")[0].split("/")[3];
                    path = `file:/${path}/${iconName}.png`;
                    icon = path;
                }
                icon;
            }
            implicitSize: 16
        }
    }

    HyprlandFocusGrab {
        id: grab
        windows: [popupMenu]

        onActiveChanged: popupMenu.visible = active
    }

    PopupWindow {
        id: popupMenu
        anchor {
            item: root
            rect.x: -5
            rect.y: -implicitHeight - 1
        }
        implicitWidth: menuRepeater.maxWidth + Settings.spacing * 2 + 3
        implicitHeight: {
            let items = 0;
            for (const menuItem of menuOpener.children.values) {
                if (!menuItem.isSeparator) {
                    ++items;
                }
            }
            return items * 32 + 4;
        }
        color: "transparent"

        QsMenuOpener {
            id: menuOpener
            menu: root.modelData.menu
        }

        Container {
            anchors.fill: parent

            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                Repeater {
                    id: menuRepeater
                    model: menuOpener.children
                    property int maxWidth: 1

                    onCountChanged: {
                        let max = 0;
                        for (let i = 0; i < menuRepeater.count; ++i) {
                            let width = menuRepeater.itemAt(i).width;
                            max = max > width ? max : width;
                        }
                        this.maxWidth = max;
                    }

                    MenuItem {}
                }
            }
        }
    }
}
