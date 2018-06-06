#ifndef PLAYLIST_H
#define PLAYLIST_H
#include <iostream>
#include "song.h"

using namespace std;

class playlist
{
public:
    playlist();

private:
    void readJson();
    void writeToJson();
};

#endif // PLAYLIST_H
