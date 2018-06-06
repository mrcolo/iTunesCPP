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
    QString name;
    QString artist;
    QString album;
    QString path;
};

#endif // SONG_H
