#include "server.h"

Server::Server(QObject *parent) : QObject(parent)
{
    m_server = new QTcpServer();
    m_socket = new QTcpSocket();
}

void Server::stopServer(){
    if(m_server != nullptr){
        m_server->close();
    }
    if(m_socket != nullptr){
        m_socket->close();
        m_socket->disconnectFromHost();
    }
    disconnect(m_server, nullptr, nullptr, nullptr);
    disconnect(m_socket, nullptr, nullptr, nullptr);
}

void Server::startServer(){
    stopServer();

    m_server->listen(QHostAddress::Any, 80000);

    connect(m_server, &QTcpServer::newConnection, this, &Server::onNewConnection);
}

// По сути этот слот вызывается когда у сокета уже статус 3 (соединение установлено)
void Server::onNewConnection(){
    qDebug() << "Server: new connection\n";
    emit connected();
    m_socket = m_server->nextPendingConnection();

    connect(m_socket, &QAbstractSocket::stateChanged, this, &Server::onStateChanged);
}

// При отключении клиента получаем коды 6 и 0
void Server::onStateChanged(){
    qDebug() << "Server status: " << m_socket->state() << "\n";
    if(m_socket->state() == QAbstractSocket::UnconnectedState){
        emit disconnected();
        stopServer();
    }
}
