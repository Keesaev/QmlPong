#ifndef TST_CONTROLLER_H
#define TST_CONTROLLER_H

#include <QObject>
#include "controller.h"
#include <QtTest/QtTest>

class tst_controller : public QObject
{
    Q_OBJECT
public:
    explicit tst_controller(QObject *parent = nullptr);
private slots:
    void isValidIp();
signals:

};

#endif // TST_CONTROLLER_H
