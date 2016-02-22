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
                highlightColor: view.color
                noteComponent: Component {
                    Note {
                        color: "#FFFF66"

                        title: "Title"
                        content: "Content"
                    }
                }

                onSelected: {
                    if (index < 0) {
                        view.clear()
                        return
                    }

                    var note = model.get(index).note
                    view.reset(note)
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
                id: viewBackground
                anchors.fill: parent
                color: "#eeeeee"

                StackView {
                    id: view

                    anchors.centerIn: parent
                    width: 300
                    height: 300

                    property alias color: viewBackground.color

                    function reset(note) {
                        var prevNote = pop()
                        if (prevNote)
                            prevNote.visible = false

                        note.visible = true
                        push(note)
                    }

                    delegate: StackViewDelegate { }
                }
            }
        }
    }

    Component.onCompleted: {
        noteList.newNote()
        noteList.newNote()
    }
}
