import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

MouseArea {
    id: mouseArea
    width: 24
    height: 24
    implicitWidth: 24
    implicitHeight: 24
    clip: true

    property color hoverColor: setAlpha(theme.textColor, 0.1)
    property color pressedColor: setAlpha(theme.textColor, 0.2)

    hoverEnabled: true
    Rectangle {
        anchors.fill: parent
        color: mouseArea.containsMouse ? hoverColor : "transparent"
    }

    onPressed: {
        pressedPoint.movePressedPoint = false
        pressedPoint.x = mouse.x
        pressedPoint.y = mouse.y
        pressedPoint.movePressedPoint = true
        pressedPoint.x = mouseArea.width / 2
        pressedPoint.y = mouseArea.height / 2
    }

    Item {
        id: pressedPoint
        width: 0
        height: 0

        property bool movePressedPoint: false
        Behavior on x {
            enabled: pressedPoint.movePressedPoint
            NumberAnimation { duration: 400 }
        }
        Behavior on y {
            enabled: pressedPoint.movePressedPoint
            NumberAnimation { duration: 400 }
        }

        Rectangle {
            id: pressedRect
            anchors.centerIn: parent
            visible: mouseArea.pressed
            color: hoverColor
            readonly property real manhattanLength: mouseArea.width + mouseArea.height
            radius: manhattanLength
            property real size: mouseArea.pressed ? manhattanLength : 0
            width: size
            height: size
            Behavior on size {
                NumberAnimation { duration: 400 }
            }
        }
    }

    function setAlpha(c, a) {
        return Qt.rgba(c.r, c.g, c.b, a)
    }

    property alias iconSource: iconItem.source
    AppletIcon {
        id: iconItem
        anchors.centerIn: parent
        width: 16
        height: 16
        source: "window-close-symbolic"
    }
}
