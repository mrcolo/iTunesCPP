#ifndef SONG_H
#define SONG_H
#include <iostream>
#include <QImage>
#include <QString>
#include <QStringList>
#include <QJsonArray>
#include <QJsonDocument>
#include <QFile>
#include <QFileDialog>
#include <QFileInfo>

//included for taglib
#include <iomanip>
#include <stdio.h>
#include <tag.h>
#include <fileref.h>
#include <tpropertymap.h>

using namespace std;

class song
{
public:
    song(string path_to_mp3);
    string getTitle();
    string getArtist();
    string getAlbum();
    string getGenre();
    string getPath();


private:
    QString title;
    QString artist;
    QString album;
    QString genre;
    QString path;

    TagLib::FileRef songf;

};

#endif // SONG_H
