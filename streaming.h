#ifndef STREAMING_H
#define STREAMING_H

#include <QObject>
#include <iostream>
#include <QUdpSocket>
#include <QString>

class Streaming : public QObject
{
    Q_OBJECT
public:
    explicit Streaming(QObject *parent = nullptr);
    QUdpSocket *m_socket = nullptr;
    QHostAddress m_address;
    int m_recvPort = 80001;
    int m_sendPort = 80002;
    void setReceiverPort(int port){ m_recvPort = port; }
    void setSenderPort(int port){ m_sendPort = port; }
    void setAddress(QString address) { m_address = QHostAddress(address); }
public slots:
    void slotStart();
    void slotStop();
    void onReadyRead();
    void sendData(QString data);
signals:
    void dataReceived(QString type, int a, int b, int c);
};

#endif // STREAMING_H
