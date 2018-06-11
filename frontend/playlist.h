#ifndef PLAYLIST_H
#define PLAYLIST_H
#include <iostream>
#include <QDebug>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>
#include "song.h"

using namespace std;

class playlist
{
public:
    playlist(string name);
    playlist(string name, QStringList songpathlist);
    ~playlist();

    void add_to_playlist(string filepath);

    void readPlistJson(QString fileName);
    void saveJson(QString fileName);
    inline bool plistJsonExists(string fileName);
    void setPlistCounter();
    void savePlaylist();

    //qstring list of unique id's for library

private:
    vector<song> list;

    int plistCounter = 0;
    QString plist_path;
//    QJsonObject plistObject;
    QJsonArray plistArray;

};

#endif // PLAYLIST_H
