#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtTest/QTest>

#include "tst_controller.h"
#include "controller.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    qmlRegisterType<Controller>("Controller", 1, 1, "Controller");
    engine.load(url);

    //QTest::qExec(new tst_controller, argc, argv);

    return app.exec();
}
