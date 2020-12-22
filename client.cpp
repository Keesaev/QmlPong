#include "client.h"

Client::Client(QObject *parent) : QObject(parent)
{
    m_socket = new QTcpSocket();
}

// Разорвать подключение

void Client::stopClient(){
    if(m_socket != nullptr){
        m_socket->abort();
        m_socket->close();
        m_socket->disconnectFromHost();
    }
    disconnect(m_socket, nullptr, nullptr, nullptr);
}

void Client::startClient(QString address){
    stopClient();

    m_socket->connectToHost(address, 4000);

    connect(m_socket, SIGNAL(connected()),
            this, SIGNAL(connected()));
}

void Client::onStateChanged(){
    if(m_socket->state() == QAbstractSocket::UnconnectedState){
        emit disconnected();
        stopClient();
    }
    qDebug() << "Client Status" << m_socket->state();
}
