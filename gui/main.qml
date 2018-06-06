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
            width: 100
            from: 1
            value: 100
            to: 100
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
                       museng.setCurrent(drop.urls[0])
                       inputArea.text = "Drag a Song here"
                       popup.close();
                   }
               }
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
        anchors.top: addPlaylist.bottom

        ScrollView {
            id: viewPlaylist
            topPadding: 30
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
             id: commands
             width:parent.width

            Button{
                width:parent.width/6
                text: "Previous"
                padding:20
            }
            Button{
                width:parent.width/6
                text: "Play"
                padding:20
                onClicked: {
                    museng.playSound()
                }
            }
            Button{
                width:parent.width/6
                text: "Pause"
                padding:20
                onClicked: {
                    museng.pauseSound()
                }
            }
            Button{
                width:parent.width/6
                text: "Next"
                padding:20
            }
            Button{
                width:parent.width/6
                text: "Loop"
                padding:20
            }
            Button{
                width:parent.width/6
                text: "Shuffle"
                padding:20
            }

          }
           Row{
             anchors.top: commands.bottom
             id: commands2
             width:parent.width

             ScrollView {
                 anchors.top: addPlaylist.bottom
                 width: parent.width
                 padding: 0
                 height:600

                 ListView {
                     model: ListModel {
                         ListElement {
                             _id: "bella"
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
                         id: control2
                         width: parent.width + 50
                         height: 40
                         text: number
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
                             console.log(_id)
                         }
                     }

                 }
             }

          }

        }

    }

    InitializeEngine{
        id: museng
    }

    footer: Bar{
        class_name: "footer energized"
        title: "Made with ❤️  by Francesco, Arman, and Ryan"
    }
}
