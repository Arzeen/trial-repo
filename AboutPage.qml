import QtQuick 2.15

Rectangle{
    id:aboutPageBackground
    width:parent.width*0.7
    height:parent.height*0.7
    anchors.centerIn:parent
    color:"black"
    border.width:3
    border.color:"white"
    Rectangle{
        color:"black"
        Text{
            text: "About"
            font.pixelSize:30
            color:"#ffffff"
            anchors{
                left:aboutIcon.right
                leftMargin:30
            }
        }
        Image{
            id:aboutIcon
            anchors{
                left: parent.left
                leftMargin:40
            }
            source:"qrc:/images/info.png"
            height:40
            width:40
        }

        width:parent.width
        height:parent.height/8
        border.width:3
        border.color:"white"
    }

    Text{
        anchors{
            top:parent.top
            left:parent.left
            leftMargin:40
            topMargin:60}

        color:"white"
        font.pixelSize:30
        text:"Made By Shadaan"
}
}
