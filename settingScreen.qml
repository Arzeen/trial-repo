import QtQuick 2.15
import QtQuick.Controls 2.12
Rectangle {
    id:settingScreen
    color:"black"
    anchors.fill:parent

    Image{
        id:backButton
        anchors{
            left:parent.left
            top:parent.top
            margins:10
        }
        width:70
        height:70
        source:"qrc:/images/left.png"
        MouseArea{
            anchors.fill:parent
            onClicked:{
                if(settingsStackView.depth>=2)
                    settingsStackView.pop()
                else
                    mainLoader.source="UI/HomeScreen/HomeScreen.qml"
            }
        }
    }




    StackView{
        id:settingsStackView
        anchors.fill:parent
        initialItem:"SettingsMainMenu.qml"
    }
}
