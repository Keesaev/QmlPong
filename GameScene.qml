import QtQuick 2.0

Rectangle {
    id: gameScene
    color: "black"
    width: parent.width
    height: parent.height

    property var otherBallx: ball.x
    property var otherBally: ball.y
    property var otherPlayerY: notActivePlayer.y
    property var fps: 15
    property var activePlayer: left
    property var notActivePlayer: right
    property var pointsToWin: 3

    FontLoader{
        id: pressStart2p;
        source: "qrc:/PressStart2P-Regular.ttf"
    }

    signal dataGenerated(string data)
    signal gameOver()

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

            checkPoints()

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
            font.pixelSize: 32
            font.family: pressStart2p.name
            color: "white"
        }
        Text {
            id: rightPoints
            text: right.points.toLocaleString()
            font.pixelSize: 32
            font.family: pressStart2p.name
            color: "white"
        }
    }

    ConnectionWindow{
        id: messageWindow

        buttonText: "Выход"
        // @disable-check M16
        onClosing:{
            gameOver()
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

    // Играбельная доска слева
    function setHostPlayer(){
        activePlayer = left
        notActivePlayer = right
        left.setPlayable(true)
        right.setPlayable(false)
    }

    // Играбельная доска справа
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

    // Управление доской играбельного игрока
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

            // При столкновении с игроком меняем вектор скорости мяча
            if(checkPlayersCollision(ball, left, right))
                ball.xSpeed *= -1

            // При столкновении с горизонтальными стенами меняем вектор скорости мяча
            if(checkHorizontalWallCollision(ball))
                ball.ySpeed *= -1

            // Двигаем мяч исходя из полученных данных
            ball.x = (ball.x + otherBallx) / 2
            ball.y = (ball.y + otherBally) / 2

            // Двигаем мяч исходя из наших данных
            ball.x += ball.xSpeed
            ball.y += ball.ySpeed

            // Исходя из полученных данных перемещаем неиграбельного игрока
            notActivePlayer.y = otherPlayerY

            // Если изменяется счет, отправляем сообщение типа "b"
            if(checkLeftWallCollision(ball) || checkRightWallCollision(ball)){

                ball.x = ball.parentWidth / 10;
                ball.y = ball.parentHeight / 10;
                ball.xSpeed = Math.abs(ball.xSpeed)
                ball.ySpeed = Math.abs(ball.ySpeed)

                dataGenerated("b;" +
                              left.points + ";" +
                              right.points + ";")

                // Проверяем, не достигли ли игроки нужного для победы числа очков
                var msg = checkPoints(activePlayer, notActivePlayer)
                if(msg != ""){
                    messageWindow.setMessage(msg)
                    messageWindow.show()
                    messageWindow.setVisible(true)
                    timer.stop()
                }
            }

            // Отправляем сообщение типа "а"
            dataGenerated("a;" + activePlayer.y + ";" +
                          ball.x + ";" +
                          ball.y + ";")
        }
    }

    // Столкновение с левой стеной
    function checkRightWallCollision(a){
        if(a.x >= a.parentWidth - 20){
            left.points++
            return true
        }
        else
            return false
    }

    // Столкновение с правой стеной
    function checkLeftWallCollision(a){
        if(a.x <= 0){
            right.points++
            return true
        }
        else
            return false
    }

    // Столкновение с горизонтальными стенами
    function checkHorizontalWallCollision(a){
        if(a.y >= a.parentHeight - 20 ||
                a.y <= 0)
            return true
        else
            return false
    }

    // Столковение с игроками

    function checkPlayersCollision(b, l, r){
        if(b.x <= l.x + l.width &&
                b.x + b.width >= l.x &&
                b.y <= l.y + l.height &&
                b.y + b.height >= l.y)
        {
            return true
        }
        else
            if(b.x + b.width >= r.x &&
                    b.x <= r.x + r.width &&
                    b.y <= r.y + r.height &&
                    b.y + b.height >= r.y)
            {
                return true
            }
        else
                return false
    }

    // Проверяем не окончилась ли игра
    function checkPoints(a, n){
        var message = a.points + " : " + n.points;
        if(a.points >= pointsToWin)
        {
            message = "Вы выиграли со счетом\n" + message;
        }
        else if(n.points >= pointsToWin){
            message = "Вы проиграли со счетом\n" + message;
        }
        else
            message = ""
        return message
    }
}
