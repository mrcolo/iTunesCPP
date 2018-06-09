#ifndef LIBRARY_H
#define LIBRARY_H
#include <iostream>
#include "playlist.h"

using namespace std;

class library
{
public:
    library();

    void create_playlist();
    void add_to_playlist();
    void add_to_library();

    void remove_from_playlist();


private:

};

#endif // LIBRARY_H
