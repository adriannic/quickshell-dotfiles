pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    Process {
        id: free
        property real value: 0
        running: true
        command: ['bash', '-c', 'df | head -n2 | tail -n1 | sed \'s/\\(\\s\\)*/\\1/g\' | sed \'s/%//g\' | cut -d\' \' -f5']
        stdout: SplitParser {
            onRead: text => free.value = text
        }
    }

    readonly property alias free: free.value
}
