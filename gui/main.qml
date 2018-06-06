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
                   museng.playSound()
                    popup.open()
                }
            }

        }

        class_name: "header"
        title: "🔥 myMusic 🔥"
    }

    Popup {
           id: popup
           x: myApp.width - 200
           y: titleBar.y
           width: parent.width/4
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
                       console.log(drop.urls)
                       inputArea.text = "Drag a Song here"
                   }
               }
           }
       }
    Grid {
        columns: 2
        spacing: 0
        width: parent.width
        height: parent.height

        ScrollView {
            width: parent.width/4
            height: parent.height

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
                    width: parent.width
                    height: 50
                    text: number
                    font.pixelSize: 15
                    background: null
                    onClicked: {
                        console.log(_id)
                    }
                }

            }
        }

        Grid {

            width: parent.width
            height: parent.height/1.5
            rows: 2

           Row{
             id: commands
               width:parent.width
            ButtonDefault {
                text: "Previous"
            }
            ButtonDefault {
                text: "Play"
            }
            ButtonDefault {
                text: "Next"
            }
            ButtonDefault {
                text: "Loop"
            }
            ButtonDefault {
                text: "Shuffle"
            }
          }
           ScrollView {
               width: parent.width
               height: parent.height

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
                       width: parent.width
                       height: 50
                       text: number
                       font.pixelSize: 15
                       background: null
                       onClicked: {
                           console.log(_id)
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
