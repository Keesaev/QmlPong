import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import Controller 1.0

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
                    if(controller.startClient()){
                        startGame()
                    }
                    connectionWindow.hide()
                }
            }
            TextEdit{
                Layout.fillHeight: true
                text: "127.0.0.1"
                font.pointSize: 14
            }
        }
    }

    function startGame(){
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
    }

    // Окно подключения к серверу
    ConnectionWindow{
        id: connectionWindow
    }

    // Контроллер
    Controller{
        id: controller
    }

    // Окно ожидания подключений
    WaitForConnection{
        id: waitForConnectionWindow

        // @disable-check M16
        onClosing:{
            controller.cancelConnection()
        }
    }

    // Сигналы контроллера
    Connections{
        target: controller
        function onConnected(){
            startGame()
        }
        function onDisconnected(){
            gameWindow.close()
        }
    }
}
