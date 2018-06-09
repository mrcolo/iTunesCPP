#ifndef INITIALIZEENGINE_H
#define INITIALIZEENGINE_H
#include <QObject>
#include "../backend/soundengine/musicengine.h"
#include <QString>
#include <QJsonObject>

class InitializeEngine :
        public QObject
{
    Q_OBJECT
public:
     InitializeEngine();
    ~InitializeEngine();
    musicEngine* museng;
    bool isPlaying = false;
    Q_INVOKABLE void playSound();
    Q_INVOKABLE void setCurrent(QString path);
    Q_INVOKABLE QJsonObject getLibrary();
    Q_INVOKABLE QJsonObject getPlaylist();
};

#endif // INITIALIZEENGINE_H
