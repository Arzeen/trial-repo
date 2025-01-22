import QtQuick 2.15
import QtQuick.Controls 2.15
import Shadaan 1.0 // Assuming WifiManager is your custom type

Rectangle {
    width: 640
    height: 480
    color: "#f0f0f0" // Background color for the Rectangle

    WifiManager {
        id: wifiManager
    }

    // Scan Wi-Fi Button
    Button {
        id:scanNetworks
        text: "Scan for Wi-Fi Networks"
        width: parent.width - 40
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            networkListView.model.clear(); // Clear existing networks before scanning
            var networks = wifiManager.getAvailableNetworks(); // Get available networks
            if (networks.length > 0) {
                networks.forEach(function(network) {
                    networkListView.model.append({ "name": network }); // Append networks to model
                });
            } else {
                console.log("No networks found.");
            }
        }
    }

    // ListView to display Wi-Fi networks
    ListView {
        id: networkListView
        width: parent.width - 40
        height: parent.height - 180
        anchors.top: scanNetworks.bottom
        anchors.topMargin: 20 // Margin from the button
        model: ListModel {} // Initially empty
        anchors.horizontalCenter: parent.horizontalCenter
        delegate:
            Rectangle {
                width: parent.width
                height: 40
                color: "lightblue"
                border.color: "blue"

                Text {
                    anchors.centerIn: parent
                    text: name // Display SSID of each Wi-Fi network
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        wifiManager.selectedNetwork = name;
                    }
                }
            }

    }

    // Password TextField
    TextField {
        id: passwordField
        width: parent.width - 40
        height: 40
        anchors.top: networkListView.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "Enter Wi-Fi password"
        echoMode: TextInput.Password
    }

    // Connect Button
    Button {
        text: "Connect to Network"
        width: parent.width - 40
        height: 40
        anchors.top: passwordField.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        enabled: wifiManager.selectedNetwork !== "" && passwordField.text.length > 0
        onClicked: {
            wifiManager.connectToNetwork(wifiManager.selectedNetwork, passwordField.text);
        }
    }
}
