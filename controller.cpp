#include "controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
    m_server = new Server();
    m_client = new Client();
}

void Controller::cancelConnection(){
    qDebug() << "cancelConnection";
    m_server->stopServer();
    m_client->stopClient();
}

void Controller::startServer(){
    m_server->startServer();
    // Повторяем сигналы, чтобы отловить их в main.qml
    connect(m_server, &Server::connected,
            this, &Controller::connected);
    connect(m_server, &Server::disconnected,
            this, &Controller::disconnected);
}

bool Controller::startClient(){
    if(m_client->startClient()){
        connect(m_client, &Client::disconnected,
                this, &Controller::disconnected);
        return true;
    }
    else
        return false;
}
