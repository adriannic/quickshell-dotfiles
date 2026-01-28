import Quickshell
import QtQml

Scope {
  Hotbar {}
  Gauges {}
  // Toasts {}

  Connections {
    target: Quickshell
    function onReloadCompleted() {
      Quickshell.inhibitReloadPopup()
    }
  }
}
