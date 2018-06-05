#include "initializeengine.h"
#include "../backend/soundengine/musicengine.h"
#include <iostream>

InitializeEngine::InitializeEngine()
{
    museng = new musicEngine();
    string test = dir.currentPath().toUtf8().constData();
     museng->setWhatToPlay("../../../example.wav");
}

InitializeEngine::~InitializeEngine()
{
     delete museng;

}

void InitializeEngine::playSound(){

        museng->play();
    std::cout<<"should work"<<std::endl;
}
