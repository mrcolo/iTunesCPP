#ifndef INITIALIZEENGINE_H
#define INITIALIZEENGINE_H
#include <QObject>
#include "../backend/soundengine/musicengine.h"
#include <QString>
#include <QJsonObject>
#include "../frontend/library.h"
#include <vector>

class InitializeEngine :
        public QObject
{
    Q_OBJECT
public:
     InitializeEngine();
    ~InitializeEngine();
    musicEngine* museng;
    library* lib;
    bool musicIsPlaying = false;
    Q_INVOKABLE void addSong(QString path);
    Q_INVOKABLE void stopSound();
    Q_INVOKABLE void setVolume(int volume);
    Q_INVOKABLE void playSound();
    Q_INVOKABLE bool isFinished();
    Q_INVOKABLE void loop();
    Q_INVOKABLE bool isPlaying();
    Q_INVOKABLE void pauseSound();
    Q_INVOKABLE void setCurrent(QString path);
    Q_INVOKABLE QJsonArray getLibrary();
    Q_INVOKABLE QJsonArray getPlaylist(QString name);
    Q_INVOKABLE QJsonArray getMyPlaylists();
    Q_INVOKABLE void addPlaylist(QString name, QVector<int> mySongs);
    Q_INVOKABLE QString getCurrentTime();
    Q_INVOKABLE QString getTotalTime();
    Q_INVOKABLE QString currentime();
    Q_INVOKABLE QString totaltime();
    Q_INVOKABLE void setPos(int pos);

};

#endif // INITIALIZEENGINE_H
