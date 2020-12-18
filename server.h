#ifndef SERVER_H
#define SERVER_H

#include <QObject>
#include <QAbstractSocket>
#include <QTcpServer>
#include <QTcpSocket>
#include <QNetworkDatagram>
#include <QDebug>

class Server : public QObject
{
    Q_OBJECT
public:
    explicit Server(QObject *parent = nullptr);
    QTcpServer *m_server = nullptr;
    QTcpSocket *m_socket = nullptr;

    void startServer();

public slots:
    void onNewConnection();
    void onStateChanged();
    void stopServer();
signals:
    void disconnected();
    void connected();
};

#endif // SERVER_H
