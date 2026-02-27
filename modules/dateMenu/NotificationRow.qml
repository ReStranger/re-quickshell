import QtQuick
import qs.components
import qs.config

Item {
    id: root

    width: ListView.view?.width ?? child.implicitWidth

    readonly property bool isFirst: index === 0
    readonly property bool isLast: ListView.view ? index === (ListView.view.count - 1) : true

    implicitHeight: child.implicitHeight + (isLast ? 0 : separator.implicitHeight)

    Rectangle {
        id: background
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: child.implicitHeight
        color: Theme.color.bg00

        topLeftRadius: root.isFirst ? Theme.rounding.windowRounding : 0
        topRightRadius: root.isFirst ? Theme.rounding.windowRounding : 0
        bottomLeftRadius: root.isLast ? Theme.rounding.windowRounding : 0
        bottomRightRadius: root.isLast ? Theme.rounding.windowRounding : 0
    }

    NotificationItem {
        id: child
        width: root.width

        title: modelData?.summary ?? ""
        body: modelData?.body ?? ""
        image: modelData?.image ?? modelData?.appIcon ?? ""
        rawNotification: modelData
        tracked: true
        buttons: modelData?.actions?.map(action => ({
                    label: action.text,
                    onClick: () => action.invoke(),
                }))
        border.width: 0
    }

    Rectangle {
        id: separator
        visible: !root.isLast
        anchors {
            top: background.bottom
            left: parent.left
            right: parent.right
        }
        implicitHeight: 1
        color: Theme.color.border00
        opacity: 0.8
    }
}
