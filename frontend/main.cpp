//#include <QApplication>
//#include <QQmlApplicationEngine>
#include <iostream>
#include "../backend/soundengine/musicengine.h"
#include "initializeengine.h"

using namespace std;

int main(int argc, char *argv[])
{
    musicEngine museng;
     museng.setWhatToPlay("example.wav");
     museng.play();

     char c = ' ';
     cout<<"works";
     while(c != 'q'){
         cin>>c;
         museng.play();
     }
     return 0;
    //QApplication app(argc, argv);
    //qmlRegisterType<InitializeEngine>("io.qt.examples.initializeengine", 1, 0, "InitializeEngine");
    //museng.play();
    //QQmlApplicationEngine engine;
    //engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
   //return app.exec();

}
