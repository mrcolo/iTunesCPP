TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
        ../backend/soundengine/musicengine.cpp \
        ../frontend/initializeengine.cpp \
        ../frontend/song.cpp \
        ../frontend/playlist.cpp

RESOURCES += qml.qrc
OTHER_FILES += \
		main.qml \
		README.md \
		src/variables/base.js \
		src/variables/buttons.js \
		src/variables/colors.js \
		src/variables/items.js \
		src/variables/badges.js \
		src/variables/fontawesome.js \
		src/styles/TouchStyle.qml \
		src/buttons/ButtonDefault.qml \        
		src/styles/TouchOutlineStyle.qml \
		src/styles/ListDividerStyle.qml \
		src/lists/List.qml \
		src/lists/DefaultListView.qml \
		src/lists/IconListView.qml \
		src/styles/DefaulListViewStyle.qml \
		src/styles/IconListViewStyle.qml \
		src/examples/ButtonPage.qml \
		src/examples/DefaultListPage.qml \
		src/examples/IconListPage.qml \
    src/lists/AvatarListView.qml \
    src/styles/AvatarListViewStyle.qml \
    src/examples/AvatarListPage.qml \
    src/content/TextContent.qml \
    src/styles/ThumbnailListViewStyle.qml \
    src/lists/ThumbnailListView.qml \
    src/examples/ThumbnailListPage.qml \
    src/styles/TouchClearStyle.qml \
    src/bars/Bar.qml \
    src/variables/bars.js \
    src/bars/ButtonBar.qml \
    src/examples/ButtonBarPage.qml \
    src/cards/Card.qml \
    src/styles/CardStyle.qml \
    src/examples/CardPage.qml



# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =
QMAKE_MAC_SDK = macosx10.9
# Default rules for deployment.
include(deployment.pri)

HEADERS += ../backend/soundengine/musicengine.h \
           ../frontend/initializeengine.h \
           ../frontend/song.h \
           ../frontend/playlist.h

macx: LIBS += -L$$PWD/irrKlang-64bit-1.6.0/bin/macosx-gcc/ -lirrklang

INCLUDEPATH += $$PWD/irrKlang-64bit-1.6.0/bin/macosx-gcc
DEPENDPATH += $$PWD/irrKlang-64bit-1.6.0/bin/macosx-gcc

INCLUDEPATH += $$PWD/irrKlang-64bit-1.6.0/include
DEPENDPATH += $$PWD/irrKlang-64bit-1.6.0/include

mac {
  Resources.files += "irrKlang-64bit-1.6.0/bin/macosx-gcc/libirrklang.dylib"
  Resources.files += "irrKlang-64bit-1.6.0/bin/macosx-gcc/ikpFLAC.dylib"
  Resources.files += "irrKlang-64bit-1.6.0/bin/macosx-gcc/ikpMP3.dylib"
# you can put more of these as you need, and it can even copy folders
# Resources.files += what you need
  Resources.path = Contents/MacOS
  QMAKE_BUNDLE_DATA += Resources
}

