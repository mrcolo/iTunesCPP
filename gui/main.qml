import QtQuick 2.3
import QtQuick.Controls 2.2

import "src/lists"
import "src/bars"
import "src/buttons"
import "src/variables/fontawesome.js" as FontAwesome
import io.qt.examples.initializeengine 1.0


ApplicationWindow {

    Component.onCompleted: {
        museng.myLibrary = museng.getLibrary();
        museng.setCurrent(museng.myLibrary[currentIndex].path)
        textCurrentSong.text = "<b>" + museng.myLibrary[currentIndex].title + "</b>" + " by " + "<b>" + museng.myLibrary[currentIndex].artist + "</b>"
    }
    Item{
        focus: true
        Keys.onTabPressed: {
            myApp.isReduced = !myApp.isReduced;
        }
    }
    function checkFinished() {
           if(museng.isFinished() && loop.loopIt && playButton.isPlaying)
               museng.playSound();

           if(museng.isFinished() && !loop.loopIt && shuffle.shuffleIt && playButton.isPlaying){
               var newIndex = Math.random() * (museng.myLibrary.length);

               if(newIndex <= museng.myLibrary.length && newIndex != currentIndex){
                   currentIndex = newIndex
                   museng.setCurrent(museng.myLibrary[currentIndex].path)
                   textCurrentSong.text = "<b>" + museng.myLibrary[currentIndex].title + "</b>" + " by " + "<b>" + museng.myLibrary[currentIndex].artist + "</b>"
                   museng.playSound();
               }
           }

           museng.myTotalTime = museng.getTotalTime()
           museng.myCurrentTime = museng.getCurrentTime()

           totalSong.text = museng.myTotalTime;
           currentSong.text = museng.myCurrentTime;

           museng.currenTime = museng.currentime()
           museng.totalTime = museng.totaltime()

           if(museng.isFinished() && playButton.isPlaying){
                if(currentIndex + 1 <= museng.myLibrary.length){
                    currentIndex++;
                    museng.setCurrent(museng.myLibrary[currentIndex].path)
                    textCurrentSong.text = "<b>" + museng.myLibrary[currentIndex].title + "</b>" + " by " + "<b>" + museng.myLibrary[currentIndex].artist + "</b>"
                    museng.playSound();
                }
           }


           counterplaylist.text = "You Selected " + playlistPopup.myVector.length + " Elements"
        }


    id: myApp
    property int currentIndex : 0
    property bool isReduced : false
    visible: true
    width: !isReduced ? 800 : 600
    height: !isReduced ? 1280 : 110

    Timer {
        interval: 500
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
       color: "white"

       anchors.top: addPlaylist.bottom
       Text{
        id: textCurrentSong
        text:""
        x: parent.width/2-80
        y: parent.height/2-30
       }
       Text{
        property int myCurrentTime : museng.getCurrentTime()
        id: currentSong
        text: myCurrentTime
        anchors.right: pointLength.left
        y: pointLength.y +10

       }

       Slider {
            id: pointLength
           anchors.top: textCurrentSong.bottom
           x: textCurrentSong.x - 170
           width: 500
           from: 1
           value: (parseInt(museng.currenTime*100/museng.totalTime))
           to: 100
           onPressedChanged: {
               museng.setPos((pointLength.value* parseInt(museng.totalTime))/100);
           }
       }
       Text{
        property string myTotalTime : museng.myTotalTime
        id: totalSong
        text: myTotalTime
        anchors.left: pointLength.right
        y: pointLength.y +10
       }

    }
    Popup {
           property var myVector : []

           id: playlistPopup
           x: parent.width/2 - 250
           y: -50
           width: 500
           height: 900
           modal: true
           focus: true
           closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
           Text{
            id:titleAdd
            font.pointSize: 60
            x:parent.width/2 - 180
            text:"Select Songs "
           }
           Text{
            id:playlistName
            anchors.top : titleAdd.bottom
            text:"Title "
            font.pointSize: 40
           }

           TextInput{
               id: inputName
            anchors.top : playlistName.bottom
            color: "grey"
            text: "Insert name"
            font.pointSize: 20

           }
           ScrollView {
               anchors.top:inputName.bottom
               id: myPlaylistSongs
               width: 400
               topPadding: 20
               height:600

               ListView {
                   id: viewSongsListPlaylist
                   property ListModel bella : library

                   model: ListModel{
                      id:library
                     }

                   Component.onCompleted: {
                       for(var song in museng.myLibrary)
                           library.append(museng.myLibrary[song]);
                   }

                   delegate: Button {
                       id: control3
                       width: parent.width + 50
                       height: 40
                       text: "<b>" + title + "</b>" + " by " + "<b>" + artist + "</b>" + " from " + "<i> " +  album + "</i>"
                       font.pixelSize: 15
                       contentItem: Text {
                               text: control3.text
                               font: control3.font
                               opacity: enabled ? 1.0 : 0.3
                               color: control3.down ? "#75bcff" : "#1386f2"
                               horizontalAlignment: Text.AlignLeft
                               verticalAlignment: Text.AlignVCenter
                               elide: Text.ElideRight
                           }

                       background: Rectangle {
                                       implicitWidth: parent.width
                                       implicitHeight: 5
                                       opacity: enabled ? 1 : 0.3
                                       border.color: control3.down ? "dbd9d9" : "#f2f2f2"
                                       border.width: 0.5
                                       radius: 1
                                   }
                       onClicked: {
                           playlistPopup.myVector.push(index)

                       }
                   }

               }
           }
           Text{
            id:counterplaylist
            anchors.top : myPlaylistSongs.bottom
            font.pointSize: 20
            text:"You selected " + playlistPopup.myVector.length + " Elements"
           }
           ButtonDefault{
               anchors.top: counterplaylist.bottom
               class_name: "energized"
               width: parent.width
               id: addThisPlaylist
               text: "Add Playlist"
               onClicked: {
                   museng.addPlaylist(inputName.text, playlistPopup.myVector)
                   museng.myPlaylists = museng.getMyPlaylists();
                   viewmyPlaylistsview.myPlaylists.clear();

                   for(var playlist in museng.myPlaylists)
                       viewmyPlaylistsview.myPlaylists.append(museng.myPlaylists[playlist])

                   playlistPopup.close()
               }
           }
       }
    ButtonDefault{
        class_name: "energized"
        width: parent.width
        id: addPlaylist
        text: "Add Playlist"
        onClicked: {
            playlistPopup.myVector = [];
            museng.myLibrary = museng.getLibrary()
            viewSongsListPlaylist.bella.clear()
            for(var song in museng.myLibrary)
                viewSongsListPlaylist.bella.append(museng.myLibrary[song]);

            playlistPopup.open();

        }
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
                id: viewmyPlaylistsview
                 model: ListModel{
                   id:playlists
                  }
                Component.onCompleted: {

                    for(var playlist in museng.myPlaylists)
                        playlists.append(museng.myPlaylists[playlist]);
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
                            color: control.down ? "#75bcff" : (name == "Library" ? "#F0B841" : "#515151")
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
                        if(name != "Library"){
                            museng.myLibrary = museng.getPlaylist(name)
                            myApp.currentIndex = 0

                            viewSongsListPlaylist.bella.clear()
                            viewSongsList.bella.clear();

                            for(var song in museng.myLibrary){
                                viewSongsListPlaylist.bella.append(museng.myLibrary[song]);
                                viewSongsList.bella.append(museng.myLibrary[song]);
                            }
                        }
                        else{
                            museng.myLibrary = museng.getLibrary();
                            myApp.currentIndex = 0

                            viewSongsListPlaylist.bella.clear()
                            viewSongsList.bella.clear();

                            for(var song in museng.myLibrary){
                                viewSongsListPlaylist.bella.append(museng.myLibrary[song]);
                                viewSongsList.bella.append(museng.myLibrary[song]);
                            }

                        }


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
                     property ListModel bella : playlistlibrary
                      model: ListModel{
                        id:playlistlibrary
                       }
                     Component.onCompleted: {

                         for(var song in museng.myLibrary)
                             playlistlibrary.append(museng.myLibrary[song]);
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
                                 color: control2.down || currentIndex == index ? "#75bcff" : "#1386f2"
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
        property var totalTime;
        property var currenTime;
        property var myTotalTime : []
        property var myCurrentTime : []
        Component.onCompleted: {
            myLibrary = museng.getLibrary()
            myPlaylists = museng.getMyPlaylists()

            myTotalTime = museng.getTotalTime()
            myCurrentTime = museng.getCurrentTime()
            currenTime = museng.currentime();
            totalTime = museng.totaltime();

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
            icon.color: loopIt ? "#F0B841" : "black"
            padding:20                    
            onClicked: loopIt = !loopIt
        }
       Button{
           width:parent.width/6
           icon.source: "qrc:/src/icons/previous.svg"
           padding:20
           onClicked : {
               if(shuffle.shuffleIt){
                   var newIndex = Math.random() * (museng.myLibrary.length);

                   if(newIndex <= museng.myLibrary.length && newIndex != currentIndex){
                       currentIndex = newIndex
                       museng.setCurrent(museng.myLibrary[currentIndex].path)
                       textCurrentSong.text = "<b>" + museng.myLibrary[currentIndex].title + "</b>" + " by " + "<b>" + museng.myLibrary[currentIndex].artist + "</b>"
                       museng.playSound();
                   }
               }
               else
                   if(currentIndex - 1 >= 0){
                       if(museng.isPlaying())
                            museng.stopSound();
                       myApp.currentIndex--;
                       museng.setCurrent(museng.myLibrary[currentIndex].path)
                       textCurrentSong.text = "<b>" + museng.myLibrary[currentIndex].title + "</b>" + " by " + "<b>" + museng.myLibrary[currentIndex].artist + "</b>"
                       museng.playSound();
                   }
                   else{
                       museng.stopSound();
                       myApp.currentIndex = 0;
                       museng.setCurrent(museng.myLibrary[currentIndex].path)
                       textCurrentSong.text = "<b>" + museng.myLibrary[currentIndex].title + "</b>" + " by " + "<b>" + museng.myLibrary[currentIndex].artist + "</b>"
                       museng.playSound();

                   }
               if(!playButton.isPlaying)
                   playButton.isPlaying = true



           }
       }
       Button{
           width:parent.width/6
           icon.source: "qrc:/src/icons/stop.svg"
           padding:20
           onClicked: {

               if(museng.isPlaying())
                  museng.stopSound();
               else
                   if(!museng.isFinished())
                       museng.stopSound()

               myApp.currentIndex = 0
               museng.setCurrent(museng.myLibrary[currentIndex].path)
               textCurrentSong.text = "<b>" + museng.myLibrary[currentIndex].title + "</b>" + " by " + "<b>" + museng.myLibrary[currentIndex].artist + "</b>"

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
           onClicked:{
               if(shuffle.shuffleIt){
                   var newIndex = Math.random() * (museng.myLibrary.length);

                   if(newIndex <= museng.myLibrary.length && newIndex != currentIndex){
                       currentIndex = newIndex
                       museng.setCurrent(museng.myLibrary[currentIndex].path)
                       textCurrentSong.text = "<b>" + museng.myLibrary[currentIndex].title + "</b>" + " by " + "<b>" + museng.myLibrary[currentIndex].artist + "</b>"
                       museng.playSound();
                   }
               }
               else
                   if(currentIndex + 1 <= museng.myLibrary.length){
                       if(museng.isPlaying())
                            museng.stopSound();
                       myApp.currentIndex++;
                       museng.setCurrent(museng.myLibrary[currentIndex].path)
                       textCurrentSong.text = "<b>" + museng.myLibrary[currentIndex].title + "</b>" + " by " + "<b>" + museng.myLibrary[currentIndex].artist + "</b>"
                       museng.playSound();
                   }
                   else{
                       museng.stopSound();
                       myApp.currentIndex = 0;
                       museng.setCurrent(museng.myLibrary[currentIndex].path)
                       textCurrentSong.text = "<b>" + museng.myLibrary[currentIndex].title + "</b>" + " by " + "<b>" + museng.myLibrary[currentIndex].artist + "</b>"
                       museng.playSound();

                   }

               if(!playButton.isPlaying)
                   playButton.isPlaying = true

           }
       }
       Button{
           id: shuffle
           property bool shuffleIt: false
           width:parent.width/6
           icon.source: "qrc:/src/icons/shuffle.svg"
           icon.color: shuffleIt ? "#F0B841" : "black"
           padding:20
           onClicked : {
            shuffleIt = !shuffleIt;
           }

       }
    }


     }
}
