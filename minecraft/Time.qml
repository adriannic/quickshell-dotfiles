pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string day: {
        Qt.formatDateTime(clock.date, "d")
    }

    readonly property string hours: {
        Qt.formatDateTime(clock.date, "h")
    }
    readonly property string minutes: {
        Qt.formatDateTime(clock.date, "m")
    }
    readonly property string seconds: {
        Qt.formatDateTime(clock.date, "s")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
