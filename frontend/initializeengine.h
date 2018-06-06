#ifndef INITIALIZEENGINE_H
#define INITIALIZEENGINE_H
#include <QObject>
#include "../backend/soundengine/musicengine.h"

class InitializeEngine :
        public QObject
{
    Q_OBJECT
public:
     InitializeEngine();
    ~InitializeEngine();
    musicEngine* museng;
    //musicEngine museng;
    Q_INVOKABLE void playSound();
    Q_INVOKABLE void setCurrent(std::string path);
    Q_INVOKABLE void pauseSound();
};

#endif // INITIALIZEENGINE_H
