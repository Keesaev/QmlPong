import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import Controller 1.1

Window{
    title: "Игра по сети"
    id: mainWindow
    visible: true

    width: 400
    height: 200

    ColumnLayout{

        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Button{
            Layout.fillWidth: true
            Layout.fillHeight: true

            text: "Создать игру"
            font.pointSize: 14

            onClicked: {
                waitForConnectionWindow.show()
                controller.startServer()
            }
        }

        RowLayout{

            Button{
                Layout.fillHeight: true
                text: "Подключиться по адресу:"
                font.pointSize: 14

                onClicked: {
                    connectionWindow.show()
                    if(controller.startClient(address.text)){
                        startGame()
                        gameWindow.setClientPlayer()
                        controller.startClientStreaming(address.text)
                    }
                    connectionWindow.visible = false
                }
            }
            TextEdit{
                id: address
                Layout.fillHeight: true
                text: "127.0.0.1"
                font.pointSize: 14
            }
        }
    }

    function startGame(){
        gameWindow.setInit()
        mainWindow.visible = false
        waitForConnectionWindow.hide()
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
        }
        onSendData: {
            controller.onSendData(data)
        }
    }

    // Окно подключения к серверу
    ConnectionWindow{
        id: connectionWindow
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
    }

    // Окно ожидания подключений
    WaitForConnection{
        id: waitForConnectionWindow

        // @disable-check M16
        onClosing:{
            controller.cancelConnection()
        }
    }
}
