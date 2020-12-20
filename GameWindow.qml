import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {
    title: "Понг"

    width: 800
    height: 650

    signal sendData(string data)
    property var ready: false
    property var otherReady: false

    RowLayout{
        Button{
            font.pointSize: 16
            text: "Готов"
            onClicked: {
                ready = true
            }
        }
        Button{
            text: "Выйти"
            font.pointSize: 16
        }
    }

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
