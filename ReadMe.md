# Material Notifications

A modified version of [plasma's notification widget](https://github.com/KDE/plasma-workspace/tree/master/applets/notifications). The widget can only be displayed in the bottom right since it needs to compile a C++ `plasmoid.nativeInterface` to detect the screen the widget is displayed on.

## Install

After installing the widget, you'll need to right click the "triangle" expander in the system tray to open the System Tray Settings. Under Extra Items, uncheck the default "Notifications" widget, and make sure "Notifications (Material)" is checked. Then restart plasmashell by either relogging or running `killall plamashell; kstart5 plasmashell`.

## Screenshots

![](https://i.imgur.com/StvCQKs.jpg)

![](https://i.imgur.com/WCZiGWm.png)

For comparison, this is what Chrome's notifications look like:

![](https://i.imgur.com/Ua1ADPJ.jpg)
