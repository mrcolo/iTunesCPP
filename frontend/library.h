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
    void create_playlist(string plist_name);
    void add_to_library(string filepath);
    void readLibJson(QString fileName);
    void saveJson(QString fileName);
    inline bool libJsonExists(string fileName);
    void setLibCounter();

private:
    int libCounter = 1;
    QJsonObject libraryObject;
};

#endif // LIBRARY_H
