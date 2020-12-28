#include "tst_controller.h"

tst_controller::tst_controller(QObject *parent) : QObject(parent)
{

}

void tst_controller::isValidIp(){
    Controller c;
    QCOMPARE(c.isValidIp("127.1.0.0"), true);
    QCOMPARE(c.isValidIp("127.1.0."), false);
    QCOMPARE(c.isValidIp(""), false);
    QCOMPARE(c.isValidIp("...."), false);
    QCOMPARE(c.isValidIp("1234.56.7.8"), false);
}
