import Quickshell
import QtQuick

Rectangle {
    id: root
    required property int scale
    required property string text
    property bool isExp: false
    property bool isTitle: false
    property int wrapMode: Text.NoWrap
    property int elide: Text.ElideNone
    property int maximumLineCount: 65536
    readonly property alias lineCount: fg.lineCount
    implicitWidth: fg.contentWidth + scale - 4
    implicitHeight: fg.contentHeight - scale * 2
    color: "transparent"
    Text {
        id: bg
        anchors.fill: parent
        anchors.leftMargin: root.scale
        text: root.text
        font.family: Settings.font.family
        font.weight: Settings.font.weight
        font.styleName: Settings.font.styleName
        font.pixelSize: 10 * root.scale
        color: root.isExp ? "#000000" : "#3e3e3e"
        wrapMode: root.wrapMode
        elide: root.elide
        maximumLineCount: root.maximumLineCount
        lineHeightMode: Text.FixedHeight
        lineHeight: 10 * root.scale
        antialiasing: false
        renderType: Text.NativeRendering
    }
    Text {
        id: fg
        anchors.fill: parent
        anchors.margins: -root.scale
        anchors.leftMargin: 0
        anchors.rightMargin: root.scale
        text: root.text
        font.family: Settings.font.family
        font.weight: Settings.font.weight
        font.styleName: Settings.font.styleName
        font.pixelSize: 10 * root.scale
        color: root.isExp ? "#7efc20" : root.isTitle ? "#fc86fc" : "#fcfcfc"
        wrapMode: bg.wrapMode
        elide: bg.elide
        maximumLineCount: bg.maximumLineCount
        lineHeightMode: Text.FixedHeight
        lineHeight: 10 * root.scale
        antialiasing: false
        renderType: Text.NativeRendering
    }
}
