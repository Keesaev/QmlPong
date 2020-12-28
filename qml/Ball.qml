import QtQuick 2.0

Rectangle{

    width: 20
    height: 20
    color: "white"

    x: parent.width / 2
    y: parent.height / 2

    // Вектор скорости / направления

    property var xSpeed: 15
    property var ySpeed: 15

    property var parentWidth: parent.width
    property var parentHeight: parent.height
}
