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

    bool startClient();

public slots:
    void onStateChanged();
    void stopClient();
signals:
    void disconnected();
};

#endif // CLIENT_H
