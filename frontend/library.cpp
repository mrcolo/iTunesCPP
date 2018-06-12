#include "library.h"

library::library()
{
    if(libJsonExists("../../../../backend/library.json"))
    {
        readLibJson("../../../../backend/library.json");
        cout<<"library.json exists!"<<endl;
    } else {
        ofstream file("../../../../backend/library.json");
        file.close();
        cout<<"library.json doesn't exist!"<<endl;
    }
    checkPlaylist();
    setLibCounter();
}

library::~library(){
    saveJson("../../../../backend/library.json");
}

void library::create_playlist(QString plistName, QVector<int> pathVector)
{
    playlist newPlaylist(plistName.toStdString());
    for(int i : pathVector) {
        newPlaylist.add_to_playlist(libraryArray[i].toObject().value("path").toString().toStdString());
    }

}

void library::add_to_library(string filepath)
{
    bool dupe = false;
    song addedSong(filepath);

    for(int i = 0; i<libraryArray.size(); i++) {
        if(libraryArray[i].toObject().value("path") == addedSong.getPath()) {
            dupe = true;
            break;
        }
    }


    if(!dupe && addedSong.check_mp3()) {
        QJsonObject songObject;
        songObject.insert("index", libCounter);
        songObject.insert("title", addedSong.getTitle());
        songObject.insert("artist", addedSong.getArtist());
        songObject.insert("album", addedSong.getAlbum());
        songObject.insert("genre", addedSong.getGenre());
        songObject.insert("path", addedSong.getPath());

        libraryArray.append(songObject);
        libCounter++;
    } else {
        cout<<"Song is already in library or is not an mp3/wav/flac file."<<endl;
    }

    saveJson("../../../../backend/library.json");
}

void library::saveJson(QString fileName)
{
    QJsonDocument doc(libraryArray);

    QFile jsonFile(fileName);
    jsonFile.open(QFile::WriteOnly);
    jsonFile.write(doc.toJson());
}

void library::readLibJson(QString fileName)
{
    QString libString;
    QFile file;
    file.setFileName(fileName);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    libString = file.readAll();
    file.close();

    QJsonDocument libDocument = QJsonDocument::fromJson(libString.toUtf8());
    qWarning() << libDocument.isNull(); // <- print false
    libraryArray = libDocument.array();
    qWarning() << libraryArray[0];  // <- print my title
}

inline bool library::libJsonExists (string fileName) {
    ifstream f(fileName.c_str());
    cout<<"filename for jsonexists: "<<fileName<<endl;
    return f.good();
}

void library::setLibCounter() {
    for(auto song : libraryArray) {
        libCounter++;
    }
}

void library::checkPlaylist(){
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
