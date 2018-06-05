import QtQuick 2.9
import QtQuick.Controls 2.2
import io.qt.examples.initializeengine 1.0
ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")
    InitializeEngine{
        id: myeng
    }
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1Form {
            Button {
                text: "Button"
                onClicked: {
                    myeng.playSound()
                }
            }
        }

        Page2Form {
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Page 1")
        }
        TabButton {
            text: qsTr("Page 2")
        }
    }
}
