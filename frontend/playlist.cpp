#include "playlist.h"

playlist::playlist(string name)
{
    string path="../../../../backend/playlists/";
    path.append(name);
    path.append(".json");

    if(plistJsonExists(path))
    {
        cout<<"Playlist exists, Overwriting..."<<endl;
    }

    ofstream file(path);
    file.close();

    plist_path = QString::fromStdString(path);
    setPlistCounter();

    savePlaylistJson(plist_path);
//    savePlaylist();

}

playlist::playlist(string name, QStringList songpathlist){

    string path="../../../../backend/";
    path.append(name);
    path.append(".json");
    QString qpath=QString::fromStdString(path);

    if(plistJsonExists(path))
    {
        readPlistJson(qpath);
        cout<<"playlist with name "<<name<<" already exists!"<<endl;
    }
    else {
        ofstream file(path);
        file.close();
    }


    plist_path=qpath;
    setPlistCounter();

    for(int i=0; i<songpathlist.size();++i){
        add_to_playlist(songpathlist[i].QString::toStdString());
    }

}


playlist::~playlist(){
    saveJson(plist_path);
}

void playlist::add_to_playlist(string filepath){


    bool dupe=false;
    song addedSong(filepath);
    QJsonObject songObject;

        for(int i = 0; i<plistArray.size(); i++) {
            if(plistArray[i].toObject().value("path") == addedSong.getPath()){
                dupe = true;
                break;
            }
        }

    bool mp3_checker=addedSong.check_mp3();

    if(!dupe && mp3_checker){
        songObject.insert("index", plistCounter);
        songObject.insert("title", addedSong.getTitle());
        songObject.insert("artist", addedSong.getArtist());
        songObject.insert("album", addedSong.getAlbum());
        songObject.insert("genre", addedSong.getGenre());
        songObject.insert("path", addedSong.getPath());

    plistArray.append(songObject);
    plistCounter++;
    }
    else{
        cout<<"Song is already in playlist or is not an mp3 file"<<endl;
    }
    savePlaylistJson(plist_path);
}


void playlist::saveJson(QString fileName)
{
    QJsonDocument doc(plistArray);
    qDebug() << doc.toJson();

    QFile jsonFile(fileName);
    jsonFile.open(QFile::WriteOnly);
    jsonFile.write(doc.toJson());
}

void playlist::readPlistJson(QString fileName)
{
    QString libString;
    QFile file;
    file.setFileName(fileName);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    libString = file.readAll();
    file.close();

    QJsonDocument libDocument = QJsonDocument::fromJson(libString.toUtf8());
    qWarning() << libDocument.isNull(); // <- print false
    plistArray = libDocument.array();
    qWarning() << plistArray[0].toObject().value(QString("title"));  // <- print my title
}

inline bool playlist::plistJsonExists (string fileName) {
    ifstream f(fileName.c_str());
    cout<<"filename for jsonexists: "<<fileName<<endl;
    return f.good();
}

void playlist::setPlistCounter() {
    for(auto song : plistArray) {
        plistCounter++;
    }
}

void playlist::savePlaylistJson(QString fileName)
{
    QJsonDocument doc(plistArray);

    QFile jsonFile(fileName);
    jsonFile.open(QFile::WriteOnly);
    jsonFile.write(doc.toJson());
}

//void playlist::savePlaylist(){
//    //meant to open playlist.txt, make vector of playlist name(string)
//    //, check if the currecnt playlsit name is present
//    //if so then erase it and put name at the back
//    //if not just append name to end of vector
//    //then rewrite the txt file so names are saved across runs


//    ifstream name_file("../../../../playlists/playlists.txt");

//    name_file.close();


//    ofstream file("../../../../playlists/playlists.txt");
//    file.close();
//}
