#ifndef PLAYLIST_H
#define PLAYLIST_H
#include <iostream>
#include "song.h"

using namespace std;

class playlist
{
public:
    playlist();
    void readJson();
    void writeToJson();
private:
    vector<song> list;

};

#endif // PLAYLIST_H
