import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Window{
    title: "Игра по сети"
    id: connectionWindow
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
        }

        RowLayout{

            Button{
                Layout.fillHeight: true
                text: "Подключиться по адресу:"
                font.pointSize: 14
            }
            TextEdit{
                Layout.fillHeight: true
                text: "127.0.0.1"
                font.pointSize: 14
            }
        }
    }
}
