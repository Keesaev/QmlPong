import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {
    id: window
    title: "Pong"
    width: 300
    height: 100
    color: "black"

    property var message: "Подключение"

    function setMessage(msg){
        message = msg
        update()
    }

    FontLoader{
        id: pressStart2p;
        source: "qrc:/PressStart2P-Regular.ttf"
    }

    ColumnLayout{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Label{
            text: message
            font.pixelSize: 12
            font.family: pressStart2p.name
            color: "white"
        }
        Button {
            contentItem: Text{
                text: "Отмена"
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

            onPressed: close()
        }
    }
}
