#include "song.h"

song::song(string path_to_mp3)
{
    //char* mp3name="/Users/ry/Desktop/CS3A itunes_Final/wilkinsonTEST3/example.mp3";
    //placeholder path, for testing purposes only
    const char* mp3name=path_to_mp3.c_str();

    songf=TagLib::FileRef(mp3name);
    TagLib::Tag *tag = songf.tag();

    string temp_title=path_to_mp3.substr(path_to_mp3.find_last_of('/')+1, path_to_mp3.length());

    for(int i=0; i<4;++i)
        temp_title.pop_back();

    title=QString::fromStdString(temp_title);

    if(tag->title()!=TagLib::String::null)
        title=QString::fromStdString(tag->title().toCString());
    if(tag->artist()!=TagLib::String::null)
        artist=QString::fromStdString(tag->artist().toCString());
    if(tag->album()!=TagLib::String::null)
        album=QString::fromStdString(tag->album().toCString());
    if(tag->genre()!=TagLib::String::null)
        genre=QString::fromStdString(tag->genre().toCString());

    path=QString::fromStdString(path_to_mp3.c_str());

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

bool song::check_mp3(){
    string temp=path.QString::toStdString();

    string mp3=temp.substr(temp.length()-4,temp.length());
    string wav=temp.substr(temp.length()-4,temp.length());
    string flac=temp.substr(temp.length()-5,temp.length());


    if(mp3==".mp3")
        return true;
    else if(wav==".wav")
        return true;
    else if(flac==".flac")
        return true;
    else
        return false;
}

