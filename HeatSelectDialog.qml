import QtQuick 2.15

Rectangle {
    id: heatSelectDialog
    signal destroyMe()

    anchors.fill:parent
    color:Qt.rgba(0,0,0,0)

    MouseArea{
        anchors.fill:parent
        onClicked: heatSelectDialog.destroyMe()
    }

    ListModel{
        id:heatModel
        ListElement{controlText:"Heat"}
        ListElement{controlText:"Cool"}
        ListElement{controlText:"Auto"}
    }

    Rectangle{
        id:innerRectangle
        width:parent.width/2
        height:parent.height*0.8
        anchors.centerIn: parent
        color:"black"
        border.color:"white"
        border.width:3
    }

    ListView{
        id:heatListView
        anchors.fill:innerRectangle
        model:heatModel
        interactive:false
        delegate: Rectangle{
            width:innerRectangle.width
            height:innerRectangle.height/3
            color:"black"
            border.color:"white"
            border.width:3
            radius:5
            Text{
                anchors.centerIn:parent
                color:"white"
                font.pixelSize:30
                text:controlText
            }
        MouseArea{
            anchors.fill:parent
            onClicked:{
                if(controlText==='Heat')
                    systemController.setSystemState(0)
                else if(controlText==='Cool')
                    systemController.setSystemState(1)
                else if(controlText==='Auto')
                    systemController.setSystemState(2)
                heatSelectDialog.destroyMe()
            }
        }

        }
    }

}
