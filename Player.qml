import QtQuick 2.0
import QtQuick.VirtualKeyboard 2.15

Rectangle{

    id: player
    focus: true

    width: 20
    height: 80
    color: "white"

    property var ySpeed: 20
    property var keyUp: Qt.Key_Up
    property var keyDown: Qt.Key_Down
    property var parentHeight: parent.height
    property var points: 0

    function goUp(){
        if(player.y > 0)
            player.y -= player.ySpeed
    }

    function goDown(){
        if(player.y < player.parentHeight - player.height)
        player.y += player.ySpeed
    }
}
