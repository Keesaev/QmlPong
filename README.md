# QmlPong
Classic Pong game by Atari with p2p multiplayer
## Features
* Establishing session with QTcpSockets
* Data streaming with QUdpSockets
* Graphics with QML / js
## Structure
* server.cpp / .h - Listening to pending connections
* client.cpp / .h - Connecting to listening socket
* streaming.cpp / .h - Streaming data
* controller.cpp / .h - A layer between c++ and QML
* gameScene.qml - All of the game logic
* main.qml - Main window
## Demonstration
![](demo/pong-demo.gif)
