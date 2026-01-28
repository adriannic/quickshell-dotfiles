pragma Singleton

import Quickshell
import QtQuick

Singleton {
    FontLoader {
        id: minecraftFont
        source: "fonts/MinecraftRegular-Bmg3.otf"
    }

    readonly property font font: ({
            family: minecraftFont.font.family,
            weight: minecraftFont.font.weight,
            styleName: minecraftFont.font.styleName
        })
}
