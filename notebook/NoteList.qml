import QtQuick 2.0

ListView {
    id: root

    property color highlightColor
    function select(index) { model.select(index) }

    highlightFollowsCurrentItem: true
    highlight: Rectangle {
        color: highlightColor

        anchors.left: parent ? parent.left : undefined
        anchors.right: parent ? parent.right : undefined
    }

    model: ListModel {
        function select(index) {
            if (root.currentIndex > -1 && root.currentIndex < root.count)
                get(root.currentIndex).note.visible = false

            if (index > -1)
                get(index).note.visible = true

            root.currentIndex = index
        }

        function addNote(note) {
            note.title = "Note" + count
            append({"note": note})

            select(count-1)
            root.focus = true
        }

        function removeNote(index) {
            root.model.get(index).note.visible = false
            remove(index)

            if (!count) {
                select(-1)
                return
            }

            var newIndex = 0
            if (index > 1)
                newIndex = index - 1

            select(newIndex)
            root.focus = true
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
                    select(index)
                }
            }
        }
    }

    interactive: false
    Keys.onPressed: {
        if (event.key == Qt.Key_Up && root.currentIndex > 0)
            select(root.currentIndex-1)

        if (event.key == Qt.Key_Down && root.currentIndex < root.count-1)
            select(root.currentIndex+1)
    }
}
