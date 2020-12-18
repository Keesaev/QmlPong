#include "client.h"

Client::Client(QObject *parent) : QObject(parent)
{
    m_socket = new QTcpSocket();
}

// Разорвать подключение

void Client::stopClient(){
    if(m_socket != nullptr){
        m_socket->close();
        m_socket->disconnectFromHost();
    }
    disconnect(m_socket, nullptr, nullptr, nullptr);
}

bool Client::startClient(){
    //stopClient();

    m_socket->connectToHost("127.0.0.1", 80000);

    if(!m_socket->waitForConnected(1000)){
        qDebug() << "Could not connect to host\n";
        stopClient();
        return false;
    }
    else{
        connect(m_socket, &QAbstractSocket::stateChanged, this, &Client::onStateChanged);
        return true;
    }
}

void Client::onStateChanged(){
    if(m_socket->state() == QAbstractSocket::UnconnectedState){
        emit disconnected();
        stopClient();
    }
    qDebug() << m_socket->state() << "\n";
}
