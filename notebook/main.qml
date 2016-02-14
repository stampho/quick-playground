import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: root

    title: "Notebook"
    width: 640
    height: 480
    visible: true

    ListModel {
        id: noteListModel

        function newNote() {
            var note = noteComponent.createObject(root, {"visible": false})
            note.title = "Note" + count
            append({"note": note})
        }
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        ListView {
            id: noteListView
            Layout.minimumWidth: 100

            anchors.top: parent.top
            anchors.topMargin: 5

            model: noteListModel

            highlightFollowsCurrentItem: true
            highlight: Rectangle {
                color: "lightsteelblue"
                radius: 5

                anchors.left: parent.left
                anchors.leftMargin: 5

                anchors.right: parent.right
                anchors.rightMargin: 5
            }

            delegate: Component {
                Item {
                    anchors.left: parent.left
                    anchors.leftMargin: 14

                    anchors.right: parent.right
                    anchors.rightMargin: 14

                    height: 40

                    Column {
                        Text { text: note.title; font.bold: true }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            noteListView.currentIndex = index
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                anchors.fill: parent
                color: "#3c3c3c"
            }

            // TODO(pvarga): StackView
        }
    }


    Component {
        id: noteComponent

        Note {
            anchors.centerIn: parent
            width: 300
            height: 300

            color: "#FFFF66"

            title: "Title"
            content: "Content"
        }
    }


    Component.onCompleted: {
        noteListModel.newNote()
        noteListModel.newNote()
    }
}
