import QtQuick 2.0

Rectangle{
    color: "black"
    width: parent.width
    height: parent.height

    id: gameScene

    focus: true

    property var fps: 20

    Column{
        anchors.centerIn: parent
        spacing: 20
        Repeater{
            model: 15
            Rectangle{
                width: 20; height: 20
                color: "white"
            }
        }
    }

    Row{
        anchors.margins: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        spacing: 200
        Text {
            id: leftPoints
            text: left.points.toLocaleString()
            color: "white"
            font.pointSize: 32
        }
        Text {
            id: rightPoints
            text: right.points.toLocaleString()
            color: "white"
            font.pointSize: 32
        }
    }

    Player{
        id: left
        x: 40
        y: gameScene.height / 2 - height / 2
    }

    Player{
        id: right
        x: gameScene.width - 40 - width
        y: gameScene.height / 2 - height / 2

        keyUp: Qt.Key_W
        keyDown: Qt.Key_S
    }

    Ball{
        id: ball
    }

    function movePlayer(a, event){
        if(event.key == a.keyUp) a.goUp()
            else if(event.key == a.keyDown) a.goDown()
    }

    Keys.onPressed: {movePlayer(left, event); movePlayer(right, event)}

    Timer {
        interval: 1000 / fps; running: true; repeat: true

        function checkWallCollision(){
            if(ball.x > ball.parentWidth - 20 ||
                    ball.x < 0){
                if(ball.x > ball.parentWidth - 20){
                    left.points++
                }
                else if(ball.x < 0){
                    right.points++
                }
                ball.x = ball.parentWidth / 10;
                ball.y = ball.parentHeight / 10;
                ball.xSpeed = Math.abs(ball.xSpeed)
                ball.ySpeed = Math.abs(ball.ySpeed)
            }

            if(ball.y > ball.parentHeight - 20 ||
                    ball.y < 0)
                ball.ySpeed *= -1
        }

        function checkPlayersCollision(){
            if(ball.x <= left.x + left.width &&
                    ball.x + ball.width >= left.x &&
                    ball.y <= left.y + left.height &&
                    ball.y + ball.height >= left.y)
                ball.xSpeed *= -1
            else
                if(ball.x + ball.width >= right.x &&
                        ball.x <= right.x + right.width &&
                        ball.y <= right.y + right.height &&
                        ball.y + ball.height >= right.y)
                    ball.xSpeed *= -1
        }

        onTriggered: {

            checkWallCollision()
            checkPlayersCollision()

            ball.x += ball.xSpeed
            ball.y += ball.ySpeed
        }
    }
}
