#ifndef MUSICENGINE_H
#define MUSICENGINE_H
#include <string>

#define IRRKLANG_STATIC
#include <QStringList>
#include <QDebug>
#include <QTimer>

using namespace std;

#include "irrKlang.h"
#include "ik_ISoundDeviceList.h"

#include "../frontend/song.h"


using namespace irrklang;

enum musicEngineErrors {NO_MUSIC_TO_PLAY,
                        ERROR_STARTING_ENGINE,
                        FILE_NOT_FOUND,
                        FILE_NOT_LOADED,
                        BAD_VOLUME,
                        BAD_PITCH};

namespace Ui {
class musicEngine;
}

class musicEngine
{

    //Q_OBJECT
    public:
        explicit musicEngine();
        musicEngine(string whatToPlay);
        ~musicEngine();

        QStringList& getDevices();

        float getVolume();
        float getBalance();

        void play();
        void loop(bool yes);
        void shuffle(bool yes);
        void pause ();
        void stop ();
        void fastForward();
        void rewind();
        void restart();
        void setDevice(int deviceNumber);
        void setVolume (int vol);
        void setPlayingOffset(float timeOffset);
        void setWhatToPlay(string whatToPlay);
        void setBalance(int pan);
        void onTimeOut();
        void onSoundStopped();

    private:
        string currentPlay="";
        irrklang::ISoundEngine* engine;
        irrklang::ISound* music;
        irrklang::ISoundDeviceList* deviceList;
        ik_f32 balance, volume;
        QStringList listOfDevices;
        //QTimer *timer;
};

#endif
