import QtQuick

Image {
    asynchronous: true
    visible: opacity > 0
    opacity: (status === Image.Ready) ? 1 : 0
    retainWhileLoading: true
}
