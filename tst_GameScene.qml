import QtQuick 2.0
import QtTest 1.0

Item {

    width: 800
    height: 600

    GameScene{
        id: gameScene
    }

    Ball{
        id: ball
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
    }

    TestCase{
        name: "checkHorizontalWallCollision"; when: windowShown

        function test_checkHorizontalWallCollision(){
            ball.x = 100
            ball.y = 100
            compare(gameScene.checkHorizontalWallCollision(ball), false)
            ball.x = 100
            ball.y = 0
            compare(gameScene.checkHorizontalWallCollision(ball), true)
        }
    }

    TestCase{
        name: "checkLeftWallCollision"; when: windowShown
        function test_checkLeftWallCollision(){
            ball.x = 100
            compare(gameScene.checkLeftWallCollision(ball), false)
            ball.x = 0
            compare(gameScene.checkLeftWallCollision(ball), true)
        }
    }

    TestCase{
        name: "checkRightWallCollision"; when: windowShown
        function test_checkRightWallCollision(){
            ball.x = 900
            compare(gameScene.checkRightWallCollision(ball), true)
            ball.x = 100
            compare(gameScene.checkRightWallCollision(ball), false)
        }
    }

    TestCase{
        name: "checkPlayersCollision"; when: windowShown
        function test_checkPlayersCollision(){
            ball.x = 300
            ball.y = 300
            compare(gameScene.checkPlayersCollision(ball, left, right), false)
            ball.x = 35
            ball.y = 320
            left.y = 300
            compare(gameScene.checkPlayersCollision(ball, left, right), true)
            ball.x = 760
            ball.y = 320
            right.y = 300
            compare(gameScene.checkPlayersCollision(ball, left, right), true)
        }
    }

    TestCase{
        name: "checkPoints"; when: windowShown
        function test_checkPoints(){
            left.points = 2
            right.points = 2
            compare(gameScene.checkPoints(left, right), "")
            left.points = 3
            right.points = 2
            compare(gameScene.checkPoints(left, right), "Вы выиграли со счетом\n3 : 2")
            left.points = 1
            right.points = 5
            compare(gameScene.checkPoints(left, right), "Вы проиграли со счетом\n1 : 5")
        }
    }
}
