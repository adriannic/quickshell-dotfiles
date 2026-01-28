import QtQuick

Rectangle {
    id: container
    color: Colors.background
    border.color: Colors.border
    implicitWidth: {
        let size = 0;
        for (const child of this.children) {
            size += child.implicitWidth;
        }
        return size + 4 * Settings.spacing;
    }
    anchors.margins: {
        left: Settings.spacing;
        right: Settings.spacing;
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: Settings.duration
            easing.type: Easing.InOutQuad
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: Settings.duration / 2
        }
    }

    Behavior on border.color {
        ColorAnimation {
            duration: Settings.duration
        }
    }
}
