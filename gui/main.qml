import QtQuick 2.3
import QtQuick.Controls 2.2

import "src/lists"
import "src/bars"
import "src/buttons"
import "src/variables/fontawesome.js" as FontAwesome
import io.qt.examples.initializeengine 1.0

ApplicationWindow {
    id: myApp
    visible: true
    width: 800
    height: 1280

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
                   id: dropArea;
                   anchors.fill: parent;
                   onEntered: {
                       drag.accept (Qt.CopyAction);
                       inputArea.text = "Now Drop it!"
                   }
                   onDropped: {
                       console.log ("onDropped");
                       museng.addSong(drop.urls[0])
                       console.log(viewSongs.viewSongsList.library)


                       //viewSongsList.model = museng.

                       for(var song in museng.myLibrary)
                           viewSongsList.library.append(museng.myLibrary[song]);

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
        text:"We Will Rock You - Queen"
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
                model: ListModel {
                    ListElement {
                        text: "John Brown"
                        number: "My Library"
                    }
                    ListElement {
                        text: "Sam Wise"
                        number: "Alternative Tunes"
                    }
                    ListElement {
                        text: "Bill Smith"
                        number: "Chill Vibes"
                    }
                    ListElement {
                        text: "John Brown"
                        number: "555 8426"
                    }
                    ListElement {
                        text: "Sam Wise"
                        number: "555 0473"
                    }
                    ListElement {
                        text: "Bill Smith"
                        number: "555 3264"
                    }
                    ListElement {
                        text: "John Brown"
                        number: "555 8426"
                    }
                    ListElement {
                        text: "Sam Wise"
                        number: "555 0473"
                    }
                    ListElement {
                        text: "Bill Smith"
                        number: "555 3264"
                    }
                    ListElement {
                        text: "John Brown"
                        number: "555 8426"
                    }
                    ListElement {
                        text: "Sam Wise"
                        number: "555 0473"
                    }
                    ListElement {
                        text: "Bill Smith"
                        number: "555 3264"
                    }
                    ListElement {
                        text: "John Brown"
                        number: "555 8426"
                    }
                    ListElement {
                        text: "Sam Wise"
                        number: "555 0473"
                    }
                    ListElement {
                        text: "Bill Smith"
                        number: "555 3264"
                    }
                    ListElement {
                        text: "John Brown"
                        number: "555 8426"
                    }
                    ListElement {
                        text: "Sam Wise"
                        number: "555 0473"
                    }
                    ListElement {
                        text: "Bill Smith"
                        number: "555 3264"
                    }
                    ListElement {
                        text: "John Brown"
                        number: "555 8426"
                    }
                    ListElement {
                        text: "Sam Wise"
                        number: "555 0473"
                    }
                    ListElement {
                        text: "haha"
                        number: "555 0473"
                    }


                }
                delegate: Button {
                    id: control
                    width: parent.width
                    height: 45
                    text: number
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
                        console.log(_id)
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
                     property ListModel library
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
                         text: title + " | " + album + " by " + artist
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
                             if(!playButton.isPlaying && !museng.isPlaying())
                                 playButton.isPlaying = !playButton.isPlaying;


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
        Component.onCompleted: {
            myLibrary = museng.getLibrary()

        }
    }

    footer: Row{
        id: commands

        width:parent.width
    Row{
        id: controls

        width: parent.width

        Button{
            width:parent.width/6
            icon.source: "qrc:/src/icons/loop.svg"
            padding:20
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
              if(museng.isPlaying()){
                  museng.stopSound();

                  if(playButton.isPlaying)
                      playButton.isPlaying = !playButton.isPlaying


              }

           }
       }
       Button{
           id:playButton
           property bool isPlaying: false
           width:parent.width/6
           icon.source: !isPlaying ? "qrc:/src/icons/play.svg" : "qrc:/src/icons/pause.svg"
           padding:20
           onClicked: {


                if(!isPlaying && !museng.isPlaying())
                    museng.playSound();
                else{
                    if( museng.isPlaying())
                        museng.pauseSound();
                }

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
