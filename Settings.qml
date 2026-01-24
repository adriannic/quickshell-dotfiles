pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property int spacing: 4
    readonly property font font: ({
            family: "Inter Nerd Font Propo Display SemiBold",
            pointSize: 13
        })
    readonly property int duration: 200
    readonly property variant workspaces: [1, 2, 3, 4, 5, 6, 7, 8, 9]
}
