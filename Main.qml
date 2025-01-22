import QtQuick
import Shadaan 1.0
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Thermostat")

    SystemController{
        id:systemController
    }

    Loader {
        id: mainLoader
        anchors.fill:parent
        source: "./UI/HomeScreen/HomeScreen.qml"
    }

    WifiManager {
          id: wifiManager

      }

}
