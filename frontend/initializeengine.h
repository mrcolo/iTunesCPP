#ifndef INITIALIZEENGINE_H
#define INITIALIZEENGINE_H
#include <QObject>
#include "../backend/soundengine/musicengine.h"
#include <QDir>
class InitializeEngine :
        public QObject
{
    Q_OBJECT
public:
     InitializeEngine();
    ~InitializeEngine();
    QDir dir;
    musicEngine* museng;
    //musicEngine museng;
    Q_INVOKABLE void playSound();
};

#endif // INITIALIZEENGINE_H
