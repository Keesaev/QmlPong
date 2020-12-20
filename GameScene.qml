import QtQuick 2.0

Rectangle {
    id: gameScene
    color: "black"
    width: parent.width
    height: parent.height

    signal dataGenerated(string data)

    function dataReceived(type, a, b, c){

        if(type === "a")
        {
            notActivePlayer.y = a
            otherBallx = b
            otherBally = c
        }
        else if(type === "b"){
            left.points = a
            right.points = b

            ball.x = ball.parentWidth / 10;
            ball.y = ball.parentHeight / 10;
            ball.xSpeed = Math.abs(ball.xSpeed)
            ball.ySpeed = Math.abs(ball.ySpeed)
        }

    }

    function setInit(){
        ball.x = ball.parentWidth / 10;
        ball.y = ball.parentHeight / 10;
        ball.xSpeed = Math.abs(ball.xSpeed)
        ball.ySpeed = Math.abs(ball.ySpeed)
        left.points = 0
        right.points = 0
        right.x = gameScene.width - 40 - right.width
        left.x = 40
    }

    property var otherBallx: ball.x
    property var otherBally: ball.y
    property var otherPlayerY: notActivePlayer.y
    property var fps: 15
    property var activePlayer: left
    property var notActivePlayer: right

    // Пунктир по середине

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

    // Очки игроков

    Row{
        anchors.margins: 100
        anchors.horizontalCenter: parent.horizontalCenter
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

    // Игроки

    Player{
        id: left
        x: 40
        y: gameScene.height / 2 - height / 2
    }

    Player{
        id: right
        x: gameScene.width - 40 - width
        y: gameScene.height / 2 - height / 2
    }

    function setHostPlayer(){
        activePlayer = left
        notActivePlayer = right
        left.setPlayable(true)
        right.setPlayable(false)
    }

    function setClientPlayer(){
        activePlayer = right
        notActivePlayer = left
        left.setPlayable(false)
        right.setPlayable(true)
    }

    // Мяч

    Ball{
        id: ball
    }

    function startTimer(){
        timer.running = true
    }

    function stopTimer(){
        timer.running = false
    }

    // Управление доской

    function movePlayer(a, event){
        if(event.key == a.keyUp) a.goUp()
            else if(event.key == a.keyDown) a.goDown()
    }

    Keys.onPressed: {movePlayer(activePlayer, event)}

    Timer {
        id: timer
        interval: 1000 / fps; running: false; repeat: true

        // Тело таймера

        onTriggered: {

            checkWallCollision()
            checkPlayersCollision()

            ball.x = (ball.x + otherBallx) / 2
            ball.y = (ball.y + otherBally) / 2

            ball.x += ball.xSpeed
            ball.y += ball.ySpeed

            notActivePlayer.y = otherPlayerY

            dataGenerated("a;" + activePlayer.y + ";" +
                          ball.x + ";" +
                          ball.y + ";")
        }
    }

    function hostBehavior(){

    }

    function clientBehavior(){

    }

    // Столкновение со стенами
    function checkWallCollision(){
        if(ball.x > ball.parentWidth - 20 ||
                ball.x < 0){
            if(ball.x > ball.parentWidth - 20){
                left.points++
                dataGenerated("b;" + left.points + ";" +
                              right.points + ";")
            }
            else if(ball.x < 0){
                right.points++
                dataGenerated("b;" + left.points + ";" +
                              right.points + ";")
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

    // Столковение с игроками

    function checkPlayersCollision(){
        if(ball.x <= left.x + left.width &&
                ball.x + ball.width >= left.x &&
                ball.y <= left.y + left.height &&
                ball.y + ball.height >= left.y)
        {
            ball.xSpeed *= -1
        }
        else
            if(ball.x + ball.width >= right.x &&
                    ball.x <= right.x + right.width &&
                    ball.y <= right.y + right.height &&
                    ball.y + ball.height >= right.y)
            {
                ball.xSpeed *= -1
            }
    }
}
