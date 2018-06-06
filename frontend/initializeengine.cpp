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
}

void InitializeEngine::pauseSound(){
        museng->pause();
}
