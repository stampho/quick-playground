import QtQuick 2.0

ListView {
    id: root

    property color highlightColor
    property var noteComponent
    signal selected(int index)
    function newNote() { model.newNote() }
    function removeNote(index) { model.removeNote(index) }

    highlightFollowsCurrentItem: true
    highlight: Rectangle {
        color: highlightColor

        anchors.left: parent ? parent.left : undefined
        anchors.right: parent ? parent.right : undefined
    }

    model: ListModel {
        function newNote() {
            var note = noteComponent.createObject(root, {"visible": false})
            note.title = "Note" + count
            append({"note": note})
            root.currentIndex = count - 1
            selected(root.currentIndex)
        }

        function removeNote(index) {
            if (index === undefined)
                index = root.currentIndex

            if (!count)
                return

            remove(index)

            if (!count) {
                selected(-1)
                return
            }

            var newIndex = 0
            if (index > 1)
                newIndex = index - 1

            root.currentIndex = newIndex
            selected(root.currentIndex)
        }
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
                    root.currentIndex = index
                    selected(index)
                }
            }
        }
    }
}
