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

    onClicked: event => {
        if (event.button === Qt.LeftButton) {
            popupMenu.visible = !popupMenu.visible;
            grab.active = !grab.active;
        } else {
            modelData.secondaryActivate();
        }
    }

    InvisibleContainer {
        id: container
        IconImage {
            anchors.fill: parent
            anchors.margins: Settings.spacing * 1.75
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

    TrayPopup {
        id: popupMenu
        menu: root.modelData.menu
    }
}
