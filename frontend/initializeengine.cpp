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
    lib = new library();
    museng->setWhatToPlay("../../../../example.mp3");
    qWarning()<<QDir::currentPath();
}

InitializeEngine::~InitializeEngine()
{
     delete museng;

}
void InitializeEngine::addSong(QString path){
    qWarning()<<path;
    string myPath = "/" + path.toStdString().substr(8, path.length()-8);

    std::cout<<myPath<<std::endl;

    //account for anything that is not mp3 or wav or flac

    lib->add_to_library(myPath);

}
void InitializeEngine::playSound(){
    musicIsPlaying = true;
    museng->play();

}
void InitializeEngine::setVolume(int volume){
    museng->setVolume(volume);

}

void InitializeEngine::pauseSound(){
    musicIsPlaying = false;
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
    museng->setWhatToPlay(myPath);
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

       return mySongs;
}

QJsonObject InitializeEngine::getPlaylist(QString name){
          //qWarning()<<name;
//        QString val;
//        QFile file;

//        file.setFileName("../../../../backend/playlists/"+ name + ".json");
//        file.open(QIODevice::ReadOnly | QIODevice::Text);

//        val = file.readAll();
//        file.close();

//        QJsonDocument d = QJsonDocument::fromJson(val.toUtf8());

//        QJsonObject mySongs = d.object();

//        return mySongs;
}

QJsonObject InitializeEngine::getMyPlaylists(){

        QString val;
        QFile file;

        file.setFileName("../../../../backend/playlists/myPlaylists.json");
        file.open(QIODevice::ReadOnly | QIODevice::Text);

        val = file.readAll();

        file.close();
        qWarning()<<val;
        QJsonDocument d = QJsonDocument::fromJson(val.toUtf8());

        QJsonObject myPlaylists = d.object();

        return myPlaylists;
}

void InitializeEngine::addPlaylist(QString name, vector<string> mySongs){
    //create object playlist with vector mySongs and name, name

}

bool InitializeEngine::isFinished(){
    return museng->isFinished();
}

void InitializeEngine::loop(){
    museng->loop();
}


