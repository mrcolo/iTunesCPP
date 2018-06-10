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
    playlist();

private:
    vector<song> list;

};

#endif // PLAYLIST_H
