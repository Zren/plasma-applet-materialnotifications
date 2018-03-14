import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

MouseArea {
    id: mouseArea
    width: implicitWidth
    height: implicitHeight
    implicitWidth: 38
    implicitHeight: 1 + 11 + textLabel.implicitHeight + 11 // 39
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
            color: pressedColor
            Component.onCompleted: {
                // Avoid binding loop
                manhattanLength = Qt.binding(function() { return mouseArea.width + mouseArea.height })
            }
            property real manhattanLength: 0
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

    Rectangle {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        height: 1
        color: setAlpha(theme.textColor, 0.1)
    }

    property alias iconSource: iconItem.source
    AppletIcon {
        id: iconItem
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.top: parent.top
        anchors.topMargin: 1 + 11
        width: 16
        height: 16
        source: "window-close-symbolic"
    }

    property alias text: textLabel.text
    PlasmaComponents.Label {
        id: textLabel
        anchors.left: parent.left
        anchors.leftMargin: 18 + (iconItem.source && iconItem.valid ? 30 : 0)
        anchors.top: parent.top
        anchors.topMargin: 1 + 11 //+ 10
        font.pointSize: -1
        font.pixelSize: 12 * units.devicePixelRatio // height=29px
        height: undefined
    }
}
