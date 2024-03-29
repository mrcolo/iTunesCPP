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

    void savePlaylistJson(QString fileName);

      bool checkforDupe();//checks if playlist name already exists
      void addname();//adds name to nameArray
      void readNameJson();//read playlist names into an array
      void savePlaylistName();//rewrite myPlaylist.json for updated list of names



private:
    vector<song> list;

    int plistCounter = 0;
    QString plist_path, plist_name;
    QJsonArray plistArray;
    QJsonArray nameArray;

};

#endif // PLAYLIST_H
