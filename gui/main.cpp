#include <QApplication>
#include <QQmlApplicationEngine>
#include "../frontend/initializeengine.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qmlRegisterType<InitializeEngine>("io.qt.examples.initializeengine", 1, 0, "InitializeEngine");
    
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
