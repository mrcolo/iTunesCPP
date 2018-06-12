#ifndef LIBRARY_H
#define LIBRARY_H
#include <iostream>
#include "song.h"
#include "playlist.h"

using namespace std;

class library
{
public:
    library();
    ~library();
    void create_playlist(QString plistName, QVector<int> pathVector);
    void add_to_library(string filepath);
    void readLibJson(QString fileName);
    void saveJson(QString fileName);
    inline bool libJsonExists(string fileName);
    void setLibCounter();
    void checkPlaylist();

private:
    int libCounter = 0;
    QJsonArray libraryArray;
};

#endif // LIBRARY_H
