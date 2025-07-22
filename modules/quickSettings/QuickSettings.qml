import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs
import qs.components
import qs.settings

PopupWindow {
    id: qs
    animOnWidth: true
    isVisible: Globals.visibleQS
    toggleFunction: () => Globals.toggleQS()
    width: mainColumn.implicitWidth +20
    height: mainColumn.implicitHeight+20
    anchors {
        top: true
        right: true
    }

    Item {
        anchors.fill: parent

        ColumnLayout {
            id: mainColumn
            anchors.fill: parent
            spacing: 5

            Rectangle {
                implicitWidth: grid.implicitWidth
                implicitHeight: grid.implicitHeight
                color: Config.color.bg01
                border {
                    color: Config.color.sf00
                    width: 0.5
                }
                radius: 15

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.minimumWidth: grid.implicitWidth + 15
                Layout.minimumHeight: grid.implicitHeight + 40

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10

                    Label {
                        text: "Быстрые настройки"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter
                    }

                    GridLayout {
                        id: grid
                        columns: 2
                        rowSpacing: 8
                        columnSpacing: 10
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Layout.margins: 5

                        QSToggleButton {
                            text: "Wi-Fi"
                        }
                        QSToggleButton {
                            text: "Bluetooth"
                        }
                        QSToggleButton {
                            text: "Звук"
                        }
                        QSToggleButton {
                            text: "Яркость"
                        }
                    }
                }
            }
        }
    }
}
