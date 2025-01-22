import QtQuick 2.15

Item {
    id: homeScreen
    property var heatSelectDialogHolder: null

    function createHeatSelectDialog(){
        if(heatSelectDialogHolder==null){
            var component= Qt.createComponent("HeatSelectDialog.qml")
            heatSelectDialogHolder= component.createObject(homeScreen,{"x":0,"y":0})
            if(heatSelectDialogHolder){
                heatSelectDialogHolder.anchors.fill=homeScreen
                heatSelectDialogHolder.destroyMe.connect(destroyHeatSelectDialog)}
        }
    }

    function destroyHeatSelectDialog(){
        if(heatSelectDialogHolder!=null){
            heatSelectDialogHolder.destroy()
            heatSelectDialogHolder=null
    }
    }

    Rectangle {
        id: mainBackground
        anchors.fill:parent
        color:{
            if(systemController.systemState===0)
                return "#F6D21B"
            else if(systemController.systemState===1)
                return "#439CB8"
            else{
                if(systemController.systemStatusMessage==="Heating...")
                    return "#F6D21B"
                if(systemController.systemStatusMessage==="Cooling...")
                    return "#439CB8"
            }

        }
    }

    Text {
        id: currentTempText
        anchors.centerIn: parent
        color:{
            if(systemController.systemState===0)
                return "#E74545"
            else if(systemController.systemState===1)
                return "#164F9B"
            else
                return "white"
        }
        font.pixelSize: 200
        text:systemController.currentSystemTemperature
    }

    Text{
        id: systemStatus
        anchors{
            horizontalCenter:parent.horizontalCenter
            top: currentTempText.bottom
            topMargin:5
        }
        font.pixelSize:30
        color:"white"
        text:systemController.systemStatusMessage
    }

    Image{
        id:heatCoolSelection
        anchors{
            top:control.top
            right:currentTempText.left
            rightMargin:100}
        width:70
        height:70
        source:{
            if(systemController.systemState===0)
                return "qrc:/images/flame.png"
            if(systemController.systemState===1)
                return "qrc:/images/snowflake.png"
            if(systemController.systemState===2)
                return "qrc:/images/auto.png"
    }
        MouseArea{
                anchors.fill:parent
                onClicked:createHeatSelectDialog()
            }
    }

    Image{
        id:settingsIcon
        anchors{
            bottom:control.bottom
            right:currentTempText.left
            rightMargin:100
        }
        width:70
        height:70
        source: "qrc:/images/gear.png"
        MouseArea{
            anchors.fill:parent
            onClicked:mainLoader.source="UI/SettingsScreen/settingScreen.qml"
        }
    }


    TemperatureControlSlider{
        id:control
        value:systemController.targetTemp
        anchors{
            top:parent.top
            bottom:parent.bottom
            left:currentTempText.right
            leftMargin:100
            topMargin:80
            bottomMargin:80
        }
    }
}
