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
    } else {
        ofstream file(path);
        file.close();
        cout<<"library.json doesn't exist!"<<endl;
    }

    plist_path=qpath;
    setPlistCounter();

//    for(int i=0; i<QStringList.size();++i){
//        add_to_playlist(songpathlist[i].QString::toStdString())
//    }

}


playlist::~playlist(){
    saveJson(plist_path);
}

void playlist::add_to_playlist(string filepath){
    bool dupe=false;
    song addedSong(filepath);
    QJsonObject songObject;


    /*
/*
//    for(auto song : plistObject) {
//        if(plistObject(song)QString("path")==addedSong.getPath()){
//            cout<<"Duplicate Song"<<endl;
//            dupe=true;
//        }
//    }


//    for(int i=0; i<plistObject.size(); ++i){
//        if (plistObject[song]["path"]==addedSong.getPath()){
//                        cout<<"Duplicate Song"<<endl;
//                        dupe=true;
//        }
//    }

//    QJsonArray json_arr;
//        QJsonObject::const_iterator iter = plistObject.begin();

//        while (iter != plistObject.end())
//        {
//            if ( iter->isObject() )
//            {
//                json_arr.append(ObjectToArray(iter->toObject()));
//            }
//            else
//            {
//                json_arr.append(*iter);
//            }
//            iter++;
//        }


//        QJsonArray qjs_arry=plistObject.getjsonarray;
//        for(int i=0; i<json_arr.size();++i){
//            if
//        }
*/

    /*
        QStringList path_list;
        QJsonArray jsonArray = plistObject["path"].toArray();

        foreach (const QJsonValue & value, jsonArray) {
            QJsonObject obj = value.toObject();
            path_list.append(obj["path"].toString());
        }

        for(int i=0; i<path_list.size(); ++i){
            if(path_list[i]==plist_path){
                dupe=true;
                cout<<"duplicate"<<endl;
                break;
            }

        }
*/


    for(int i=0; i<plistCounter; ++i){
        QString identity_str=QString::fromStdString(to_string(i));
        QJsonValue tempval=plistObject["path"];
        QString temp=tempval.toString();

    }




    bool checker=addedSong.check_mp3();
    if(!dupe && checker){
    songObject.insert("title", addedSong.getTitle());
    songObject.insert("artist", addedSong.getArtist());
    songObject.insert("album", addedSong.getAlbum());
    songObject.insert("genre", addedSong.getGenre());
    songObject.insert("path", addedSong.getPath());

    plistObject.insert(QString::number(plistCounter), songObject);
    plistCounter++;
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

