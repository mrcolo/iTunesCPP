import QtQuick 2.3
import QtQuick.Controls 2.2

import "src/lists"
import "src/bars"
import "src/buttons"
import "src/variables/fontawesome.js" as FontAwesome
import io.qt.examples.initializeengine 1.0


ApplicationWindow {
    function checkFinished() {




           if(museng.isFinished() && loop.loopIt && playButton.isPlaying)
               museng.playSound();


        }
    property int currentIndex
    id: myApp
    visible: true
    width: 800
    height: 1280

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: checkFinished()
    }
    FontLoader{ source: "qrc:/src/fonts/fontawesome-webfont.ttf"}

    Rectangle {
        anchors.fill: parent
    }

    header: Bar{
        id: titleBar
        leftComponent:Slider {
            id:volume
            width: 200
            from: 1
            value: 100
            to: 100
            onMoved: {
                museng.setVolume(volume.value)
            }

        }
        rightComponent: Component{

            ButtonDefault{
                id: test
                class_name: "bar dark clear"
                text: "Add Song"
                icon: FontAwesome.icons.fa_music
                onClicked: {
                    popup.open()
                }
            }
        }
        class_name: "header"
        title: "🔥 myMusic 🔥"
    }

    Popup {
           id: popup
           x: myApp.width - 310
           y: titleBar.y
           width: 300
           height: parent.height/4
           modal: false
           focus: true
           closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
           Text{
               id:inputArea
            x:parent.width/2 - 50
            y:parent.height/2 - 10
            text:"Drag a Song here "
           }

           Rectangle {
               id: background;
               color: "transparent";
               width: parent.width;
               height: parent.height;

               DropArea {
                   property ListModel mycurrentModel
                   id: dropArea;
                   anchors.fill: parent;
                   onEntered: {
                       drag.accept (Qt.CopyAction);
                       inputArea.text = "Now Drop it!"
                   }
                   onDropped: {

                       var myPath = drop.urls[0]
                        console.log("works")
                       museng.addSong(myPath)

                       museng.myLibrary = museng.getLibrary();

                       viewSongsList.bella.clear();

                       for(var song in museng.myLibrary)
                           viewSongsList.bella.append(museng.myLibrary[song]);


                       inputArea.text = "Drag a Song here"
                       popup.close();
                   }
               }
           }
       }
    Rectangle{

        width: parent.width
        height:addPlaylist.height*2
        id: bella
       color: "#E0E0E0"

       anchors.top: addPlaylist.bottom
       Text{
        id: textCurrentSong
        text:""
        x: parent.width/2-80
        y: parent.height/2-30
       }
       Text{
        property int myCurrentTime : 23
        id: remainingSong
        text: "0:" + myCurrentTime
        anchors.right: pointLength.left
        y: pointLength.y +10

       }

       Slider {
            id: pointLength
           anchors.top: textCurrentSong.bottom
           x: textCurrentSong.x - 170
           width: 500
           from: 1
           value: remainingSong.myCurrentTime
           to: 100
       }
       Text{
        property string myTotalTime : "4:23"
        id: totalSong
        text: myTotalTime
        anchors.left: pointLength.right
        y: pointLength.y +10
       }

    }
    ButtonDefault{
        class_name: "energized"
        width: parent.width
        id: addPlaylist
       text: "Add Playlist"
    }
    Grid {
        columns: 2
        spacing: 0
        width: parent.width
        height: parent.height
        anchors.top: bella.bottom
        ScrollView {
            id: viewPlaylist

            topPadding:20
            width: parent.width/4
            height: parent.height

            ListView {
                property ListModel myPlaylists : playlists

                 model: ListModel{
                   id:playlists
                  }
                Component.onCompleted: {

                    for(var song in museng.myPlaylists)
                        playlists.append(museng.myPlaylists[song]);
                }
                delegate: Button {
                    id: control
                    width: parent.width
                    height: 45
                    text: name
                    font.pixelSize: 15
                    contentItem: Text {
                            text: control.text
                            font: control.font
                            opacity: enabled ? 1.0 : 0.3
                            color: control.down ? "#75bcff" : "#515151"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }

                    background: Rectangle {
                                    implicitWidth: parent.width
                                    implicitHeight: 5
                                    opacity: enabled ? 1 : 0.3
                                    border.color: control.down ? "#ededed" : "#f9f9f9"
                                    border.width: 0.5
                                    radius: 1
                                }
                    onClicked: {
                        //museng.getPlaylist(name)
                    }
                }

            }
        }

        Grid {

            width: parent.width/1.3
            height: parent.height/1.1

           Row{

             id: commands2
             width:parent.width

             ScrollView {

                 id: viewSongs
                 width: parent.width
                 topPadding: 20
                 height:600

                 ListView {
                     id: viewSongsList
                     property ListModel bella : library
                      model: ListModel{
                        id:library
                       }
                     Component.onCompleted: {

                         for(var song in museng.myLibrary)
                             library.append(museng.myLibrary[song]);
                     }


                     delegate: Button {
                         id: control2
                         width: parent.width + 50
                         height: 40
                         text: "<b>" + title + "</b>" + " by " + "<b>" + artist + "</b>" + " from " + "<i> " +  album + "</i>"
                         font.pixelSize: 15
                         contentItem: Text {
                                 text: control2.text
                                 font: control2.font
                                 opacity: enabled ? 1.0 : 0.3
                                 color: control2.down ? "#75bcff" : "#1386f2"
                                 horizontalAlignment: Text.AlignLeft
                                 verticalAlignment: Text.AlignVCenter
                                 elide: Text.ElideRight
                             }

                         background: Rectangle {
                                         implicitWidth: parent.width
                                         implicitHeight: 5
                                         opacity: enabled ? 1 : 0.3
                                         border.color: control2.down ? "dbd9d9" : "#f2f2f2"
                                         border.width: 0.5
                                         radius: 1
                                     }
                         onClicked: {
                             if(museng.isPlaying()){
                                museng.stopSound();
                             }

                             if(!playButton.isPlaying)
                                 playButton.isPlaying = !playButton.isPlaying;

                             textCurrentSong.text = "<b>" + title + "</b>" + " by " + "<b>" + artist + "</b>"

                             myApp.currentIndex = index;
                             museng.setCurrent(path);
                             museng.playSound();


                         }
                     }

                 }
             }

          }

        }

    }

    InitializeEngine{
        id: museng
        property var myLibrary : []
        property var myPlaylists : []
        Component.onCompleted: {
            myLibrary = museng.getLibrary()
            myPlaylists = museng.getMyPlaylists()

        }
    }

    footer: Row{
        id: commands

        width:parent.width
    Row{
        id: controls

        width: parent.width

        Button{
            id: loop
            property bool loopIt: false
            width:parent.width/6
            icon.source: "qrc:/src/icons/loop.svg"
            icon.color: loopIt ? "blue" : "black"
            padding:20                    
            onClicked: loopIt = !loopIt
        }
       Button{
           width:parent.width/6
           icon.source: "qrc:/src/icons/previous.svg"
           padding:20
       }
       Button{
           width:parent.width/6
           icon.source: "qrc:/src/icons/stop.svg"
           padding:20
           onClicked: {
              console.log(museng.isPlaying())
               if(museng.isPlaying())
                  museng.stopSound();
               else
                   if(!museng.isFinished())
                       museng.stopSound()

               playButton.isPlaying = false

           }
       }
       Button{
           id:playButton
           property bool isPlaying: false
           width:parent.width/6
           icon.source: !isPlaying ? "qrc:/src/icons/play.svg" : "qrc:/src/icons/pause.svg"
           padding:20
           onClicked: {
              if(museng.isPlaying())
                museng.pauseSound();
              else
                if(museng.isFinished())
                    museng.playSound()
                else
                    museng.pauseSound()

               isPlaying = !isPlaying;
           }
       }
       Button{
           width:parent.width/6
           icon.source: "qrc:/src/icons/next.svg"
           padding:20
       }
       Button{
           width:parent.width/6
           icon.source: "qrc:/src/icons/shuffle.svg"
           padding:20

       }
    }


     }
}
