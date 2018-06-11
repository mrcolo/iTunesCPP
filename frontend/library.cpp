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
    setLibCounter();
}
library::~library(){
    saveJson("../../../../backend/library.json");
}

void library::create_playlist()
{

}

void library::add_to_library(string filepath)
{

    song addedSong(filepath);


    QJsonObject songObject;
    songObject.insert("title", addedSong.getTitle());
    songObject.insert("artist", addedSong.getArtist());
    songObject.insert("album", addedSong.getAlbum());
    songObject.insert("genre", addedSong.getGenre());
    songObject.insert("path", addedSong.getPath());


    libraryObject.insert(QString::number(libCounter), songObject);
    libCounter++;

    saveJson("../../../../backend/library.json");
}

void library::saveJson(QString fileName)
{
    QJsonDocument doc(libraryObject);

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
    libraryObject = libDocument.object();
    qWarning() << libraryObject.value(QString("title"));  // <- print my title
}

inline bool library::libJsonExists (string fileName) {
    ifstream f(fileName.c_str());
    cout<<"filename for jsonexists: "<<fileName<<endl;
    return f.good();
}

void library::setLibCounter() {
    for(auto song : libraryObject) {
        libCounter++;
    }
}
