import Quickshell
import QtQml

Scope {
  Bar {}
  Notifications {}

  Connections {
    target: Quickshell
    function onReloadCompleted() {
      Quickshell.inhibitReloadPopup()
    }
  }
}
