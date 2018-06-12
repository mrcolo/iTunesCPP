#include "playlist.h"

playlist::playlist(string name)
{    
    plist_name=QString::fromStdString(name);

    checkPlaylist();
    readNameJson();
    addname();

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

//    savePlaylistJson(plist_path);
    savePlaylistName();

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
    //savePlaylistJson(plist_path);
    saveJson(plist_path);

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


void playlist::checkPlaylist(){
    ifstream f("../../../../backend/playlists/myPlaylists.json");
    //checks if there is any playlist record txt file and if not makes it
    if(!f.good()){
        ofstream file("../../../../backend/playlists/myPlaylists.json");
        file.close();
        cout<<"playlist record didn't exist, making now"<<endl;
        QJsonArray arry;
        QJsonObject nameObject;
        nameObject.insert("name", "Library");
        arry.append(nameObject);

        QJsonDocument doc(arry);
        QFile jsonFile("../../../../backend/playlists/myPlaylists.json");
        jsonFile.open(QFile::WriteOnly);
        jsonFile.write(doc.toJson());
        //addname();
    }
}

bool playlist::checkforDupe(){
//assumes name array already set through readNameJson
    for(int i=0; i<nameArray.size();++i){
        if(nameArray[i].toObject().value("name") == plist_name)
            return true;
    }
    return false;
}

void playlist::addname(){
    //adds playlist name to namearray if its not a dupe
    if(!checkforDupe()){

    QJsonObject nameObject;
    nameObject.insert("name", plist_name);
    nameArray.append(nameObject);
    }
    else{
        cout<<"duplicate already named"<<endl;
    }
}

void playlist::readNameJson(){//gets names in file and puts in name array
    QString nameString;
    QFile file;
    file.setFileName("../../../../backend/playlists/myPlaylists.json");
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    nameString = file.readAll();
    file.close();

    QJsonDocument Document = QJsonDocument::fromJson(nameString.toUtf8());
    qWarning() << Document.isNull(); // <- print false
    nameArray = Document.array();
    qWarning() << nameArray[0];  // <- print my title
}

void playlist::savePlaylistName(){
    QJsonDocument doc(nameArray);
    qDebug() << doc.toJson();

    QFile jsonFile("../../../../backend/playlists/myPlaylists.json");
    jsonFile.open(QFile::WriteOnly);
    jsonFile.write(doc.toJson());
}

