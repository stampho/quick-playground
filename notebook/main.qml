import QtGraphicalEffects 1.0
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

    Action {
        shortcut: "Ctrl+N"
        onTriggered: {
            noteList.newNote()
        }
    }

    Action {
        shortcut: "Delete"
        onTriggered: {
            noteList.removeNote()
        }
    }

    Action {
        shortcut: "Backspace"
        onTriggered: {
            noteList.removeNote()
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

            NoteList {
                id: noteList
                anchors.fill: parent
                highlightColor: noteView.color
                focus: true

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        parent.focus = true
                        mouse.accepted = false
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

                function newNote() {
                    var note = noteComponent.createObject(noteView.contentItem)
                    model.addNote(note)
                }

                function removeNote() {
                    if (!model.count)
                        return

                    model.removeNote(currentIndex)
                }
            }
        }

        Flickable {
            id: noteView

            Layout.fillWidth: true
            Layout.fillHeight: true

            flickableDirection: Flickable.HorizontalFlick
            clip: true
            interactive: false

            property alias color: noteViewBackground.color

            Rectangle {
                id: noteViewBackground
                anchors.fill: parent
                color: "#eeeeee"
            }
        }
    }

    Component.onCompleted: {
        noteList.newNote()
        noteList.newNote()
    }
}
