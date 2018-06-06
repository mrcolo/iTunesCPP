#include "initializeengine.h"
#include "../backend/soundengine/musicengine.h"
#include <iostream>

InitializeEngine::InitializeEngine()
{
    museng = new musicEngine();
    museng->setWhatToPlay("../../../../example.wav");
}

InitializeEngine::~InitializeEngine()
{
     delete museng;

}

void InitializeEngine::playSound(){
        museng->play();
}
