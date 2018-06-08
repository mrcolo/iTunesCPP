#include "song.h"

song::song()
{
    char* mp3name="/Users/ry/Desktop/CS3A itunes_Final/wilkinsonTEST3/example.mp3";
    //placeholder path, for testing purposes only
    songf=TagLib::FileRef(mp3name);
}
string song::getName(){
    TagLib::Tag *tag = songf.tag();
    return tag->title().toCString();
}
string song::getArtist(){

}
string song::getAlbum(){

}
string song::getPath(){

}
