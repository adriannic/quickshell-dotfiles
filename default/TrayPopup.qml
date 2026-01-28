import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

PopupWindow {
    id: popupMenu
    property alias menu: menuOpener.menu
    anchor {
        item: parent
        rect.x: -4
        rect.y: -implicitHeight
    }
    implicitWidth: menuRepeater.maxWidth + Settings.spacing * 2
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

    onVisibleChanged: if (visible) {
        openSound.running = true;
    } else {
        closeSound.running = true;
    }

    Process {
        id: openSound
        command: ["sh", "-c", "mpv --no-video --volume=60 ~/.config/audio/sonic/open.wav"]
    }

    Process {
        id: closeSound
        command: ["sh", "-c", "mpv --no-video --volume=60 ~/.config/audio/sonic/close.wav"]
    }

    QsMenuOpener {
        id: menuOpener
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
