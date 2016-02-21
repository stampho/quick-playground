import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

import QtGraphicalEffects 1.0

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
            var prevNote = view.pop()
            if (prevNote)
                prevNote.visible = false
            note.visible = true;
            view.push(note)

            noteListView.currentIndex = count - 1
        }
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        LinearGradient {
            Layout.minimumWidth: 100

            start: Qt.point(0, 0)
            end: Qt.point(width, 0)

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#3c3c3c" }
                GradientStop { position: 1.0; color: "#888888" }
            }

            ListView {
                id: noteListView
                anchors.fill: parent

                model: noteListModel

                highlightFollowsCurrentItem: true
                highlight: Rectangle {
                    color: mainView.color

                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                delegate: Component {
                    Item {
                        anchors.left: parent.left
                        anchors.leftMargin: 14

                        anchors.right: parent.right
                        anchors.rightMargin: 14

                        height: 25

                        Text {
                            text: note.title
                            font.bold: true
                            color: parent.ListView.isCurrentItem ? "black" : "white"
                            elide: Text.ElideRight

                            width: parent.width
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                noteListView.currentIndex = index
                                var prevNote = view.pop()
                                if (prevNote)
                                    prevNote.visible = false

                                var note = noteListModel.get(index)["note"]
                                note.visible = true
                                view.push(note)
                            }
                        }
                    }
                }
            }
        }

        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true

            flickableDirection: Flickable.HorizontalFlick
            clip: true
            interactive: false

            Rectangle {
                id: mainView

                anchors.fill: parent
                color: "#eeeeee"

                StackView {
                    id: view

                    anchors.centerIn: parent
                    width: 300
                    height: 300

                    delegate: StackViewDelegate { }
                }
            }
        }
    }


    Component {
        id: noteComponent

        Note {
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
