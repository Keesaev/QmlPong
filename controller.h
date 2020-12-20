#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <qqml.h>

#include "server.h"
#include "client.h"
#include "streaming.h"

class Controller : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Controller(QObject *parent = nullptr);

    Server *m_server = nullptr;
    Client *m_client = nullptr;
    Streaming *m_streaming = nullptr;

    Q_INVOKABLE void startServer();
    Q_INVOKABLE bool startClient(QString address);
    Q_INVOKABLE void startServerStreaming(QString address);
    Q_INVOKABLE void startClientStreaming(QString address);
public slots:
    void stopStreaming();
    void cancelConnection();
    void onSendData(QString data);
signals:
    void connected(QString clientAddress);
    void disconnected();
    void dataReceived(QString type, int a, int b, int c);
};

#endif // CONTROLLER_H
