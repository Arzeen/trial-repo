import QtQuick 2.15

Item {
    ListModel{
        id:settingsMainMenuListModel
        ListElement{menuText:"Temperature Units";iconSource:"qrc:/images/thermometer.png"}
        ListElement{menuText:"Schedule";iconSource:"qrc:/images/calendar.png"}
        ListElement{menuText:"WiFi Settings";iconSource:"qrc:/images/wi-fi.png"}
        ListElement{menuText:"About";iconSource:"qrc:/images/info.png"}
        }
    Rectangle{
        id:stackViewBackground
        width:parent.width*0.7
        height:parent.height*0.7
        anchors.centerIn:parent
        color:"black"
        border.width:3
        border.color:"white"

    }
    ListView{
        id:settingsListView
        anchors.fill:stackViewBackground
        model:settingsMainMenuListModel
        interactive:false
        delegate: Rectangle{
            width:settingsListView.width
            height:settingsListView.height/4
            color:"black"
            border.color:"white"
            border.width:1
            radius:5
            Image{
                id:iconImage
                anchors{
                    verticalCenter:parent.verticalCenter
                    left: parent.left
                    leftMargin:30
                }
                source:iconSource
                height:48
                width:48
            }

            Text{
                anchors{
                    verticalCenter:parent.verticalCenter
                    left:iconImage.right
                    leftMargin:40
                }
                color:"white"
                font.pixelSize:30
                text:menuText
            }
        MouseArea{
            anchors.fill:parent
            onClicked:{
                if(menuText==="Temperature Units")
                settingsStackView.push("UnitsPage.qml")
                if (menuText === "WiFi Settings")
                settingsStackView.push("WifiDialog.qml") // Open Wi-Fi networks when clicked
                if(menuText==="About")
                settingsStackView.push("AboutPage.qml")
            }
        }

        }
    }
}
