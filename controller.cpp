#include "controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
    m_server = new Server();
    m_client = new Client();
    m_streaming = new Streaming();

    connect(m_server, SIGNAL(connected(QString)),
            this, SIGNAL(connected(QString)));
    connect(m_server, &Server::disconnected,
            this, &Controller::disconnected);
    connect(m_client, &Client::disconnected,
            this, &Controller::disconnected);
    connect(m_streaming, SIGNAL(dataReceived(QString, int, int, int)),
            this, SIGNAL(dataReceived(QString, int, int, int)));
}

void Controller::onSendData(QString data){
    m_streaming->sendData(data);
}

void Controller::cancelConnection(){
    qDebug() << "cancelConnection";
    m_server->stopServer();
    m_client->stopClient();
}

void Controller::stopStreaming(){
    m_streaming->slotStop();
}

void Controller::startServerStreaming(QString address){
    m_streaming->setReceiverPort(4001);
    m_streaming->setSenderPort(4002);
    m_streaming->setAddress(address);
    m_streaming->slotStart();
}

void Controller::startClientStreaming(QString address){
    m_streaming->setReceiverPort(4002);
    m_streaming->setSenderPort(4001);
    m_streaming->setAddress(address);
    m_streaming->slotStart();
}

void Controller::startServer(){
    m_server->startServer();
    // Повторяем сигналы, чтобы отловить их в main.qml
}

bool Controller::startClient(QString address){
    if(m_client->startClient(address)){
        return true;
    }
    else
        return false;
}
