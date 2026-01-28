import QtQuick

Item {
    id: root
    required property int scale
    required property string text
    property bool isExp: false
    implicitWidth: fg.contentWidth + scale - 4
    implicitHeight: fg.contentHeight - scale * 2

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Text {
            id: bg
            anchors.fill: parent
            text: root.text
            anchors.leftMargin: root.scale
            anchors.rightMargin: -root.scale
            font.family: Settings.font.family
            font.weight: Settings.font.weight
            font.styleName: Settings.font.styleName
            font.pixelSize: 10 * root.scale
            color: root.isExp ? "#000000" : "#3e3e3e"
            antialiasing: false
            renderType: Text.NativeRendering
            Text {
                id: fg
                anchors.fill: parent
                anchors.margins: -root.scale
                anchors.rightMargin: root.scale
                text: root.text
                font.family: Settings.font.family
                font.weight: Settings.font.weight
                font.styleName: Settings.font.styleName
                font.pixelSize: 10 * root.scale
                color: root.isExp ? "#7efc20" : "#fcfcfc"
                antialiasing: false
                renderType: Text.NativeRendering
            }
        }
    }
}
