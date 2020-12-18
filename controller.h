#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <qqml.h>

#include "server.h"
#include "client.h"

class Controller : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Controller(QObject *parent = nullptr);

    Server *m_server;
    Client *m_client;

    Q_INVOKABLE void startServer();
    Q_INVOKABLE bool startClient();
public slots:
    void cancelConnection();
signals:
    void connected();
    void disconnected();
};

#endif // CONTROLLER_H
