#ifndef INITIALIZEENGINE_H
#define INITIALIZEENGINE_H
#include <QObject>
#include "../backend/soundengine/musicengine.h"
#include <QString>
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
};

#endif // INITIALIZEENGINE_H
