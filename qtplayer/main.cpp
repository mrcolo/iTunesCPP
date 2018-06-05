#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "../backend/soundengine/musicengine.h"
#include <iostream>
#include "../frontend/initializeengine.h"
int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<InitializeEngine>("io.qt.examples.initializeengine", 1, 0, "InitializeEngine");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();

}
