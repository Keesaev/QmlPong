import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {
    title: "Pong"

    width: 800
    height: 600

    color: "black"

    signal sendData(string data)

    function startTimer(){
        gameScene.startTimer()
    }

    function stopTimer(){
        gameScene.stopTimer()
    }

    function setHostPlayer(){
        gameScene.setHostPlayer()
    }

    function setClientPlayer(){
        gameScene.setClientPlayer()
    }

    function dataReceived(type, a, b, c){
        gameScene.dataReceived(type, a, b, c)
    }

    function setInit(){
        gameScene.setInit()
    }

    GameScene{
        id: gameScene
        anchors.bottom: parent.bottom

        width: 800
        height: 600

        onDataGenerated: {
            sendData(data)
        }
    }
}
