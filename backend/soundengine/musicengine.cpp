#include "musicengine.h"
#include <iostream>

using namespace irrklang;
musicEngine::musicEngine()
{

    deviceList = irrklang::createSoundDeviceList();
    int deviceCount = deviceList->getDeviceCount();
    std::cout<<"Number of devices found: "<<deviceCount<<std::endl;
    for(int i = 0; i < deviceCount; ++i)
    {
        std::cout<<deviceList->getDeviceDescription(i)<<std::endl;
        std::cout<<deviceList->getDeviceDescription(i)<<std::endl;
        //listOfDevices.append(deviceList->getDeviceDescription(i));
        //listOfDevices << deviceList->getDeviceDescription(i);
    }
    setVolume(1);
    setDevice(0);
    setBalance(balance);
    std::cout<<"Ended music engine constructor."<<std::endl;
}

void musicEngine::setVolume(int vol)
{
    volume = vol;
    if(music)
        music->setVolume(volume/100.);
}

void musicEngine::setDevice(int device){
    //const char* deviceID = deviceList->getDeviceID(deviceNumber);
       if(engine)
           engine->drop();
       engine = createIrrKlangDevice();
       setBalance(0);
}

void musicEngine::setBalance(int pan)
{
    balance = -pan/50.0;
    if(music)
        music->setPan(balance);
}

musicEngine::~musicEngine()
{
    deviceList->drop();
    if (music)
        music->drop(); // release music stream.

    engine->drop(); // delete engine
}

float musicEngine::getBalance()
{
    return balance;
}

float musicEngine::getVolume()
{
    return volume;
}

/*
QStringList& musicEngine::getDevices()
{
    return listOfDevices;
}
*/

void musicEngine::loop()
{
    if(music->isFinished())
       play();
}

bool musicEngine::isFinished(){
    if(music)
        return music->isFinished();

    return true;
}

void musicEngine::play()
{
    engine->stopAllSounds();

    music = engine->play2D((currentPlay).c_str(),false, false, true);
    if(music)
    {
        std::cout<<"Attempting to play music"<<std::endl;
        music->setPan(balance);
        //volume = music->getVolume();
        std::cout<<(int)volume<<std::endl;
    }
    else{
        std::cout<<"not working";
    }


}

void musicEngine::pause()
{
    music->setIsPaused(music->getIsPaused() ? false : true);
}

void musicEngine::stop()
{
    music->stop();
}


void musicEngine::onSoundStopped()
{

}

void musicEngine::fastForward()
{
   if(music)
   {
       float currPos = music->getPlayPosition()+5000;
       if(currPos >= music->getPlayLength())
            currPos = music->getPlayLength();
        music->setPlayPosition(currPos);

   }
}

void musicEngine::rewind()
{
    if(music)
    {
      float currPos = music->getPlayPosition() - 5000;
      if(currPos <= 0)
         currPos = 0;
      music->setPlayPosition(currPos);

    }
}

void musicEngine::restart()
{
    music->setPlayPosition(0);

}



void musicEngine::setPlayingOffset(float timeOffset)
{
    float millisecs = timeOffset/100. * music->getPlayLength();
    music->setPlayPosition(millisecs);
}



void musicEngine::setWhatToPlay(std::string whatToPlay)
{
   std::cout<<"Set current play as "<<whatToPlay<<std::endl;
   currentPlay = whatToPlay;
}

void musicEngine::onTimeOut()
{
    if(music->isFinished())
    {

    }
}

