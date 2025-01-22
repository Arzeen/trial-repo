import QtQuick 2.15

Item {
    ListModel{
        id:unitsMenuListModel
        ListElement{unitsMenu:"Celcius";iconSource:"qrc:/images/thermometer.png"}
        ListElement{unitsMenu:"Farenheit";iconSource:"qrc:/images/thermometer.png"}
        }
    Rectangle{
        id:unitsBackground
        width:parent.width*0.7
        height:parent.height*0.7
        anchors.centerIn:parent
        color:"black"
        border.width:3
        border.color:"white"

    }
    ListView{
        id:settingsListView
        anchors.fill:unitsBackground
        model:unitsMenuListModel
        interactive:false
        delegate: Rectangle{
            width:unitsBackground.width
            height:unitsBackground.height/2
            color:"black"
            border.color:"white"
            border.width:1
            radius:5
            Image{
                id:imgid
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
                    left:imgid.right
                    leftMargin:40
                }
                color:"white"
                font.pixelSize:30
                text:unitsMenu
            }
        MouseArea{
            anchors.fill:parent
            onClicked:{
                if(unitsMenu==="Celcius"){
                    systemController.setSystemUnits("Celcius")
                    systemController.setCurrentSystemTemperature((systemController.currentSystemTemperature-32)*5/9)
                    systemController.setTargetTemp((systemController.targetTemp-32)*5/9)
                    mainLoader.source="UI/HomeScreen/HomeScreen.qml"
                }
                if(unitsMenu==="Farenheit"){
                    if(systemController.SystemUnits!="Farenheit"){
                    systemController.setSystemUnits("Farenheit")
                    systemController.setCurrentSystemTemperature((systemController.currentSystemTemperature*9/5)+32)
                    systemController.setTargetTemp((systemController.targetTemp*9/5)+32)
                    mainLoader.source="UI/HomeScreen/HomeScreen.qml"
                    }
                }


            }
        }

        }
    }
}
