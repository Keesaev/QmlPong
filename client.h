#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QDebug>

class Client : public QObject
{
    Q_OBJECT
public:
    explicit Client(QObject *parent = nullptr);
    QTcpSocket *m_socket = nullptr;

    void startClient(QString address);

public slots:
    void onStateChanged();
    void stopClient();
signals:
    void disconnected();
    void connected();
};

#endif // CLIENT_H
