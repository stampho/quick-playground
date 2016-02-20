import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Rectangle {
    id: root

    border.width: 1
    border.color: Qt.lighter("black")

    property alias title: title.text
    property alias content: content.text

    ColumnLayout {
        anchors.fill: parent
        spacing: 30

        Flickable {
            Layout.alignment: Qt.AlignTop
            Layout.preferredHeight: root.height / 10

            anchors.top: parent.top
            anchors.topMargin: 10

            anchors.left: parent.left
            anchors.leftMargin: 10

            anchors.right: parent.right
            anchors.rightMargin: 10

            flickableDirection: Flickable.HorizontalFlick
            clip: true
            interactive: false

            // FIXME(pvarga): Text can't be selected
            TextInput {
                id: title

                font.bold: true
                font.pixelSize: 28
                font.underline: true

                anchors.fill: parent
            }
        }

        TextArea {
            id: content

            Layout.alignment: Qt.AlignBottom
            Layout.fillHeight: true

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10

            anchors.left: parent.left
            anchors.leftMargin: 15

            anchors.right: parent.right
            anchors.rightMargin: 10

            wrapMode: TextEdit.Wrap
            backgroundVisible: false
            frameVisible: false

            // FIXME(pvarga): Enable scrollbar and change its style
            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff

            font.pixelSize: 16
        }
    }
}

