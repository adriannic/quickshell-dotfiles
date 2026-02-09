import Quickshell
import QtQml

Scope {
  Hotbar {}
  Gauges {}
  Advancements {}

  Connections {
    target: Quickshell
    function onReloadCompleted() {
      Quickshell.inhibitReloadPopup()
    }
  }
}
