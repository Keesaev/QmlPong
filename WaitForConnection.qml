import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {
    id: window
    title: "Создать игру"
    width: 300
    height: 100
    RowLayout{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Label{
            text: "Ожидание игроков..."
            font.pixelSize: 14
        }
        Button{
            text: "Отмена"
            onPressed: close()
        }
    }
}
