import QtQuick 2.0

Rectangle{

    id: player
    focus: true

    width: 10
    height: 80
    color: "white"

    property var ySpeed: 20
    property var keyUp: Qt.Key_Up
    property var keyDown: Qt.Key_Down
    property var parentHeight: parent.height
    property var points: 0
    property var isPlayable: false

    function setPlayable(a){
        isPlayable = a
    }

    function goUp(){
        if(player.y > 0 && player.isPlayable)
            player.y -= player.ySpeed
    }

    function goDown(){
        if(player.y < player.parentHeight - player.height &&
                player.isPlayable)
        player.y += player.ySpeed
    }
}
