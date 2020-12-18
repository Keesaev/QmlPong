import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {
    title: "Понг"

    width: 800
    height: 650

    RowLayout{
        Button{
            font.pointSize: 16
            text: "Начать игру"

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

    GameScene{
        id: gameScene
        anchors.bottom: parent.bottom

        width: 800
        height: 600
    }
}
