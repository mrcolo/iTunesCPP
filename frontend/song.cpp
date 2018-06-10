#include "song.h"

song::song(string path_to_mp3)
{
    //char* mp3name="/Users/ry/Desktop/CS3A itunes_Final/wilkinsonTEST3/example.mp3";
    //placeholder path, for testing purposes only
    const char* mp3name=path_to_mp3.c_str();

    songf=TagLib::FileRef(mp3name);
    TagLib::Tag *tag = songf.tag();

    title=QString::fromStdString(tag->title().toCString());
    artist=QString::fromStdString(tag->artist().toCString());
    album=QString::fromStdString(tag->album().toCString());
    genre=QString::fromStdString(tag->genre().toCString());
    path=QString::fromStdString(path_to_mp3.c_str());;
}
QString song::getTitle(){
    return title;
}
QString song::getArtist(){
    return artist;
}
QString song::getAlbum(){
    return album;
}
QString song::getGenre(){
    return genre;
}
QString song::getPath(){
    return path;
}
