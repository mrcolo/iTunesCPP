#include "initializeengine.h"
#include "../backend/soundengine/musicengine.h"
#include <iostream>

InitializeEngine::InitializeEngine()
{
    museng = new musicEngine();
    museng->setWhatToPlay("../../../../example.mp3");
}

InitializeEngine::~InitializeEngine()
{
     delete museng;

}

void InitializeEngine::playSound(){
         museng->play();

        isPlaying = !isPlaying;

}

void InitializeEngine::setCurrent(QString path){
    string myPath = path.toStdString();
    //account for anything that is not mp3 or wav or flac
    museng->setWhatToPlay(myPath.substr(8, myPath.length()-8));
}
