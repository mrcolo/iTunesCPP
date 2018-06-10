#include "initializeengine.h"
#include "../backend/soundengine/musicengine.h"
#include <iostream>
#include <QFile>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDir>

InitializeEngine::InitializeEngine()
{
    museng = new musicEngine();
    museng->setWhatToPlay("../../../../example.mp3");
    qWarning()<<QDir::currentPath();
}

InitializeEngine::~InitializeEngine()
{
     delete museng;

}

void InitializeEngine::playSound(){
    musicIsPlaying = true;
    museng->play();

}
void InitializeEngine::setVolume(int volume){
    museng->setVolume(volume);

}

void InitializeEngine::pauseSound(){
    museng->pause();
}

void InitializeEngine::stopSound(){
    musicIsPlaying = false;
    museng->stop();
}



bool InitializeEngine::isPlaying(){
    if(musicIsPlaying)
        return true;
    else
        return false;
}

void InitializeEngine::setCurrent(QString path){

    string myPath = path.toStdString();
    //account for anything that is not mp3 or wav or flac
    museng->setWhatToPlay( "/" + myPath.substr(8, myPath.length()-8));
}

QJsonObject InitializeEngine::getLibrary(){

       QString val;
       QFile file;

       file.setFileName("../../../../backend/library.json");
       file.open(QIODevice::ReadOnly | QIODevice::Text);

       val = file.readAll();
       file.close();

       QJsonDocument d = QJsonDocument::fromJson(val.toUtf8());

       QJsonObject mySongs = d.object();



        /*
       qWarning() << tr("QJsonObject[appName] of description: ") << item["description"];
       QJsonValue subobj = item["description"];
       qWarning() << subobj.toString();

       qWarning() << tr("QJsonObject[appName] of value: ") << item["imp"];
       QJsonArray test = item["imp"].toArray();
       qWarning() << test[1].toString();
       */
       return mySongs;
}

QJsonObject InitializeEngine::getPlaylist(){

}

