#ifndef SONG_H
#define SONG_H
#include <iostream>
#include <fstream>
#include <QImage>
#include <QString>
#include <QStringList>
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
    QString getTitle();
    QString getArtist();
    QString getAlbum();
    QString getGenre();
    QString getPath();
    bool check_mp3();


private:
    QString title="Undefined";
    QString artist="Undefined";
    QString album="Undefined";
    QString genre="Undefined";
    QString path;

    TagLib::FileRef songf;

};

#endif // SONG_H
