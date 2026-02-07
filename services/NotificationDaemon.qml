pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property list<NotificationObject> data: []

    NotificationServer {
        id: server

        keepOnReload: false
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: true
        imageSupported: true

        onNotification: notification => {
            notification.tracked = true;

            root.data.push(notificationComponent.createObject(root, {
                popup: true,
                notification: notification,
                shown: false
            }));
        }
    }
    function removeById(id) {
        const i = data.findIndex(n => n.notification.id === id);
        if (i >= 0) {
            data.splice(i, 1);
        }
    }

    component NotificationObject: QtObject {
        id: object

        property bool popup
        readonly property date time: new Date()
        readonly property string timeStr: {
            const diff = new Date() - time.getTime();
            const m = Math.floor(diff / 60000);
            const h = Math.floor(m / 60);

            if (h < 1 && m < 1)
                return "now";
            if (h < 1)
                return `${m}m`;
            return `${h}h`;
        }

        property bool shown: false
        required property Notification notification
        readonly property string summary: notification?.summary || ""
        readonly property string body: notification?.body || ""
        readonly property string appIcon: notification?.appIcon || ""
        readonly property string appName: notification?.appName || ""
        readonly property string image: notification?.image || ""
        readonly property int urgency: notification?.urgency ?? 0
        readonly property list<NotificationAction> actions: notification?.actions || []

        readonly property Timer timer: Timer {
            running: object.notification && object.notification.actions && object.notification.actions.length >= 0
            interval: object.notification && object.notification.expireTimeout > 0 ? object.notification.expireTimeout : 5000
            onTriggered: {
                if (true)
                    object.popup = false;
            }
        }

        readonly property Connections conn: Connections {
            target: object.notification ? object.notification.Retainable : null

            function onDropped(): void {
                if (root.data.indexOf(object) !== -1)
                    root.data.splice(root.data.indexOf(object), 1);
            }

            function onAboutToDestroy(): void {
                object.notification.destroy();
            }
        }
        readonly property Connections conn2: Connections {
            target: object.notification

            function onClosed(reason) {
                if (root.data.indexOf(object) !== -1)
                    root.data.splice(root.data.indexOf(object), 1);
            }
        }
    }

    Component {
        id: notificationComponent

        NotificationObject {}
    }
}
