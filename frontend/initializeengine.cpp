#include "initializeengine.h"
#include "../backend/soundengine/musicengine.h"
#include <iostream>
#include <QFile>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDir>
#include "playlist.h"

InitializeEngine::InitializeEngine()
{
    museng = new musicEngine();
    lib = new library();
}

InitializeEngine::~InitializeEngine()
{
     delete museng;
     delete lib;
}

void InitializeEngine::addSong(QString path){
    string myPath = "/" + path.toStdString().substr(8, path.length()-8);
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

QJsonArray InitializeEngine::getLibrary(){

       QString val;
       QFile file;

       file.setFileName("../../../../backend/library.json");
       file.open(QIODevice::ReadOnly | QIODevice::Text);

       val = file.readAll();
       file.close();

       QJsonDocument doc = QJsonDocument::fromJson(val.toUtf8());
       QJsonArray mySongs = doc.array();

       return mySongs;
}

QJsonArray InitializeEngine::getPlaylist(QString name){

    QString val;
    QFile file;

    file.setFileName("../../../../backend/playlists/" + name + ".json");
    file.open(QIODevice::ReadOnly | QIODevice::Text);

    val = file.readAll();
    file.close();

    QJsonDocument doc = QJsonDocument::fromJson(val.toUtf8());
    QJsonArray mySongs = doc.array();

    return mySongs;
}

QJsonArray InitializeEngine::getMyPlaylists(){

        QString val;
        QFile file;

        file.setFileName("../../../../backend/playlists/myPlaylists.json");
        file.open(QIODevice::ReadOnly | QIODevice::Text);

        val = file.readAll();

        file.close();

        QJsonDocument d = QJsonDocument::fromJson(val.toUtf8());

        QJsonArray myPlaylists = d.array();

        return myPlaylists;
}

void InitializeEngine::addPlaylist(QString name, QVector<int> mySongs){
    lib->create_playlist(name, mySongs);
}

bool InitializeEngine::isFinished(){
    return museng->isFinished();
}

void InitializeEngine::loop(){
    museng->loop();
}

QString InitializeEngine::getCurrentTime(){
    return QString::fromStdString(museng->getCurrentTime());
}

QString InitializeEngine::getTotalTime(){
    return QString::fromStdString(museng->getTotalTime());
}

QString InitializeEngine::totaltime(){
    return QString::fromStdString(to_string(museng->getTotalTimeInMilliseconds()));
}
QString InitializeEngine::currentime(){
    return QString::fromStdString(to_string(museng->getCurrentTimeInMilliseconds()));
}

void InitializeEngine::setPos(int pos){
    museng->setPos(pos);
}
