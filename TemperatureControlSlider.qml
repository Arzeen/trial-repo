import QtQuick
import QtQuick.Controls.Basic

Slider {
    id: control
    from:{
        if(systemController.systemUnits==="Farenheit")
            return 55
        if(systemController.systemUnits==="Celcius")
            return 16
    }

    to:{
        if(systemController.systemUnits==="Farenheit")
            return 85
        if(systemController.systemUnits==="Celcius")
            return 26
    }
    stepSize:1
    enabled: true
    orientation: Qt.Vertical
    onValueChanged:systemController.setTargetTemp(value)

    background: Rectangle {
        x: control.leftPadding + control.availableWidth / 2 - width / 2
        y: control.topPadding
        width: 3
        height: parent.height
        radius: 2
        color: "#ffffff"

        Rectangle {
            width: parent.width
            height: control.visualPosition * parent.height
            color: "#21be2b"
            radius: 2
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.availableWidth / 2 - width / 2
        y: control.topPadding + control.visualPosition * (control.availableHeight - height)
        implicitWidth: 76
        implicitHeight: 76
        radius: implicitWidth/2
        color: "black"
        border.color: "#bdbebf"

        Text{
            anchors.centerIn:parent
            color: "white"
            font.pixelSize:30
            text:control.value
        }
    }
}
