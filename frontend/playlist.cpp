#include "playlist.h"

playlist::playlist(string name)
{
    string path="../../../../backend/";
    path.append(name);
    path.append(".json");
    QString qpath=QString::fromStdString(path);

    if(plistJsonExists(path))
    {
        readPlistJson(qpath);
        cout<<"library.json exists!"<<endl;
    } else {
        ofstream file(path);
        file.close();
        cout<<"library.json doesn't exist!"<<endl;
    }

    plist_path=qpath;
    setPlistCounter();
}

playlist::playlist(string name, QStringList songpathlist){

    string path="../../../../backend/";
    path.append(name);
    path.append(".json");
    QString qpath=QString::fromStdString(path);

    if(plistJsonExists(path))
    {
        readPlistJson(qpath);
        cout<<"library.json exists!"<<endl;
    }
    else {
        ofstream file(path);
        file.close();
        cout<<"library.json doesn't exist!"<<endl;
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

        for(auto song : plistObject) {
            if(song.toObject().value("path") == addedSong.getPath()){
                dupe = true;
                break;
            }
        }

    bool mp3_checker=addedSong.check_mp3();

    if(!dupe && mp3_checker){
        songObject.insert("title", addedSong.getTitle());
        songObject.insert("artist", addedSong.getArtist());
        songObject.insert("album", addedSong.getAlbum());
        songObject.insert("genre", addedSong.getGenre());
        songObject.insert("path", addedSong.getPath());

    plistObject.insert(QString::number(plistCounter), songObject);
    plistCounter++;
    }
    else{
        cout<<"Song is already in playlist or is not an mp3 file"<<endl;
    }
}


void playlist::saveJson(QString fileName)
{
    QJsonDocument doc(plistObject);
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
    plistObject = libDocument.object();
    qWarning() << plistObject.value(QString("title"));  // <- print my title
}

inline bool playlist::plistJsonExists (string fileName) {
    ifstream f(fileName.c_str());
    cout<<"filename for jsonexists: "<<fileName<<endl;
    return f.good();
}

void playlist::setPlistCounter() {
    for(auto song : plistObject) {
        plistCounter++;
    }
}

