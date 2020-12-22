#include "streaming.h"

Streaming::Streaming(QObject *parent) : QObject(parent)
{
    m_socket = new QUdpSocket();
    m_address.setAddress("127.0.0.1");
    m_recvPort = 4001;
    m_sendPort = 4002;
}

void Streaming::slotStart(){

    slotStop();
    QHostAddress addr;
    addr.setAddress(m_address.toString());

    //m_socket->bind(addr, m_recvPort);
    m_socket->bind(QHostAddress::Any, m_recvPort);

    connect(m_socket, &QAbstractSocket::readyRead, this, &Streaming::onReadyRead);
}

void Streaming::sendData(QString data){
    QByteArray datagram;
    datagram.append(data.toUtf8());
    qDebug() << "Sending: " << data << " to " << m_address << ":" << m_sendPort;
    m_socket->writeDatagram(datagram, m_address, m_sendPort);
}

void Streaming::onReadyRead(){
    QByteArray datagram;
    datagram.resize(m_socket->pendingDatagramSize());
    m_socket->readDatagram(datagram.data(), datagram.size());

    QString result = datagram.data();
    QString type = "";

    // Парсим

    type = result.left(result.indexOf(";"));
    result = result.right(result.length() - result.indexOf(";") - 1);

    int n = 0;
    if(type == "a")
        n = 3;
    else if(type == "b")
        n = 2;
    else
        return;

    if(!result.isEmpty())
    {
        double params[n];

        for(int i = 0; i < n; i++){
            QString buf = result.left(result.indexOf(";"));
            params[i] = buf.toDouble();
            result = result.right(result.length() - result.indexOf(";") - 1);
        }

        emit dataReceived(type, params[0], params[1], params[2]);
    }
}

void Streaming::slotStop(){
    m_socket->close();
    disconnect(m_socket, nullptr, nullptr, nullptr);
}
