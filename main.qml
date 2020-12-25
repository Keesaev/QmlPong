import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import Controller 1.1

Window{
    title: "Pong"
    id: mainWindow
    visible: true

    width: 400
    height: 200
    color: "black"

    FontLoader{
        id: pressStart2p;
        source: "qrc:/PressStart2P-Regular.ttf"
    }

    ColumnLayout{

        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Button{
            Layout.fillWidth: true
            Layout.fillHeight: true

            contentItem: Text{
                text: "Создать игру";
                font.family: pressStart2p.name
                font.pointSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }

            background: Rectangle{
                color: "black"
                opacity: enabled ? 1 : 0.3
                border.color: "white"
                border.width: 1
                radius: 2
            }

            onClicked: {
                connectionWindow.setMessage("Ожидание игрока")
                connectionWindow.show()
                controller.startServer()
            }
        }

        RowLayout{

            Button{
                Layout.fillHeight: true

                contentItem: Text{
                    text: "Подключиться"
                    font.pointSize: 12
                    font.family: pressStart2p.name
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                }

                background: Rectangle{
                    color: "black"
                    opacity: enabled ? 1 : 0.3
                    border.color: "white"
                    border.width: 1
                    radius: 2
                }

                onClicked: {
                    connectionWindow.setMessage("Подключение")
                    connectionWindow.show()
                    controller.startClient(address.text)
                }
            }
            TextEdit{
                id: address
                Layout.fillHeight: true
                text: "127.0.0.1"
                font.family: pressStart2p.name
                color: "white"
                font.pointSize: 10
            }
        }
    }

    function startGame(){
        gameWindow.setInit()
        mainWindow.visible = false
        connectionWindow.hide()
        gameWindow.show()
        gameWindow.startTimer()
    }

    // Окно игры
    GameWindow{
        id: gameWindow

        // @disable-check M16
        onClosing:{
            mainWindow.visible = true
            controller.cancelConnection()
            stopTimer()
            mainWindow.update()
        }
        onSendData: {
            controller.onSendData(data)
        }
    }

    // Окно подключения к серверу
    ConnectionWindow{
        id: connectionWindow

        // @disable-check M16
        onClosing:{
            controller.cancelConnection()
        }
    }

    // Контроллер
    Controller{
        id: controller

        onConnected: {
            console.log("\"" + clientAddress + "\"")
            startGame()
            gameWindow.setHostPlayer()
            startServerStreaming(clientAddress)
        }
        onDisconnected: {
            gameWindow.close()
            stopStreaming()
        }
        // Костыль, переделать под массив
        onDataReceived: {
            console.log("TYPE: " + type)
            gameWindow.dataReceived(type, a, b, c)
        }
        onClientConnected: {
            gameWindow.setClientPlayer()
            controller.startClientStreaming(address.text)
            startGame()
        }
    }
}
