#ifndef SONG_H
#define SONG_H
#include <iostream>
#include <QImage>
#include <Qstring>
#include <QStringList>
#include <QJsonArray>
#include <QJsonDocument>
#include <QFile>
#include <QFileDialog>
#include <QFileInfo>

using namespace std;

class song
{
public:
    song();
    string getName();
    string getArtist();
    string getAlbum();
    string getPath();


private:
    Qstring name;
    Qstring artist;
    Qstring album;
    Qstring path;
};

#endif // SONG_H
