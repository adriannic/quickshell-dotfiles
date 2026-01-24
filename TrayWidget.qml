import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

Container {
    RowLayout {
        anchors.fill: parent
        spacing: 0

        Repeater {
            model: SystemTray.items
            TrayItem {}
        }
    }
}
