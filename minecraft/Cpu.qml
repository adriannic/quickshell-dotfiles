pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    Process {
        id: proc
        property real value: 0
        running: true
        command: ['bash', '-c', 'while true; do sleep 0.5; top -bn1 | grep \'Cpu(s)\' | column -to\' \' | cut -d\' \' -f8 | awk \'{print (100 - $1)/100}\'; done']
        stdout: SplitParser {
            onRead: text => proc.value = text
        }
    }

    readonly property alias usage: proc.value
}
