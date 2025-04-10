/****************************************************************************
 **
 ** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
 ** Copyright (C) 2017-2025 Chupligin Sergey <neochapay@gmail.com>
 ** All rights reserved.
 ** Contact: Nokia Corporation (qt-info@nokia.com)
 **
 ** This file is part of the QtDeclarative module of the Qt Toolkit.
 **
 ** $QT_BEGIN_LICENSE:LGPL$
 ** GNU Lesser General Public License Usage
 ** This file may be used under the terms of the GNU Lesser General Public
 ** License version 2.1 as published by the Free Software Foundation and
 ** appearing in the file LICENSE.LGPL included in the packaging of this
 ** file. Please review the following information to ensure the GNU Lesser
 ** General Public License version 2.1 requirements will be met:
 ** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
 **
 ** In addition, as a special exception, Nokia gives you certain additional
 ** rights. These rights are described in the Nokia Qt LGPL Exception
 ** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
 **
 ** GNU General Public License Usage
 ** Alternatively, this file may be used under the terms of the GNU General
 ** Public License version 3.0 as published by the Free Software Foundation
 ** and appearing in the file LICENSE.GPL included in the packaging of this
 ** file. Please review the following information to ensure the GNU General
 ** Public License version 3.0 requirements will be met:
 ** http://www.gnu.org/copyleft/gpl.html.
 **
 ** Other Usage
 ** Alternatively, this file may be used in accordance with the terms and
 ** conditions contained in a signed written agreement between you and Nokia.
 **
 **
 **
 **
 **
 ** $QT_END_LICENSE$
 **
 ****************************************************************************/ 

import QtQuick
import QtQuick.Window
import Nemo
import Nemo.Controls

import "calculator.js" as CalcEngine

ApplicationWindow {
    id: calcwindow

    property bool isUiLandscape: width < height
    property string displayOperation: ""
    property string displayText: "0"
    property string displayPrevious: ""

    contentOrientation: Screen.orientation
//    allowedOrientations:  Qt.PortraitOrientation | Qt.LandscapeOrientation | Qt.InvertedLandscapeOrientation | Qt.InvertedPortraitOrientation

    function doOp(operation) {
        CalcEngine.doOperation(operation)
        displayOperation = CalcEngine.currentOperation
        displayText = CalcEngine.currentText
        displayPrevious = CalcEngine.lastText
        history.updateText()
    }

    initialPage: Page {
        headerTools:  HeaderToolsLayout {
            title: qsTr("Calculator")
        }

        Item {
            id: main
            anchors.fill: parent
            anchors.margins: 6
            anchors.topMargin: 0

            Column {
                id: box; spacing: 8

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                Display {
                    id: display
                    width: box.width-3
                    height: 150
                }

                Rectangle {
                    height: 1
                    width: box.width
                    color: "#444444"
                    anchors {
                        horizontalCenter: parent.horizontalCenter; verticalCenterOffset: -1
                    }
                }
            }

            HistoryDisplay {
                id: history
                anchors.right: grid.left
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.margins: 12
            }

            Rectangle {
                anchors.left: history.right
                anchors.leftMargin: 24
                anchors.top: parent.top
                anchors.topMargin: 12
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12

                width: 1
                color: "#444444"
                visible: history.visible
            }

            Grid {
                id: grid
                spacing: 6
                rows: 6
                columns: 3
                anchors.top: box.bottom

                property real w: ((main.width - x) / columns) - ((spacing * (columns - 1)) / columns)
                property real h: ((main.height - y) / rows) - ((spacing * (rows - 1)) / rows)

                CalcButton { width: grid.w; height: grid.h; color: Theme.fillColor; operation: "C"; shortcut: "Esc"; }
                CalcButton { width: grid.w; height: grid.h; operation: CalcEngine.division; shortcut: "/"; togglable: true }
                CalcButton { width: grid.w; height: grid.h; operation: CalcEngine.multiplication; shortcut: "*"; togglable: true }

                CalcButton { width: grid.w; height: grid.h; operation: CalcEngine.plusminus }
                CalcButton { width: grid.w; height: grid.h; operation: "-"; shortcut: "-"; togglable: true }
                CalcButton { width: grid.w; height: grid.h; operation: "+"; shortcut: "+"; togglable: true }

                CalcButton { width: grid.w; height: grid.h; operation: "7"; shortcut: "7"; }
                CalcButton { width: grid.w; height: grid.h; operation: "8"; shortcut: "8"; }
                CalcButton { width: grid.w; height: grid.h; operation: "9"; shortcut: "9"; }

                CalcButton { width: grid.w; height: grid.h; operation: "4"; shortcut: "4"; }
                CalcButton { width: grid.w; height: grid.h; operation: "5"; shortcut: "5"; }
                CalcButton { width: grid.w; height: grid.h; operation: "6"; shortcut: "6"; }

                CalcButton { width: grid.w; height: grid.h; operation: "1"; shortcut: "1"; }
                CalcButton { width: grid.w; height: grid.h; operation: "2"; shortcut: "2"; }
                CalcButton { width: grid.w; height: grid.h; operation: "3"; shortcut: "3"; }

                CalcButton { width: grid.w; height: grid.h; operation: "0"; shortcut: "0"; }
                CalcButton { width: grid.w; height: grid.h; operation: "."; shortcut: "."; }
                CalcButton { width: grid.w; height: grid.h; operation: "="; shortcut: "Return"; color: Theme.accentColor }
            }

            states: [
                State {
                    name: "portait"
                    when: isUiPortrait
                    PropertyChanges {
                        target: history
                        visible: false
                    }
                    PropertyChanges {
                        target: box
                        visible: true
                    }
                },
                State {
                    name: "landscape"
                    when: !isUiLandscape
                    PropertyChanges {
                        target: history
                        visible: true
                    }
                    PropertyChanges {
                        target: box
                        visible: false
                    }
                    AnchorChanges {
                        target: grid
                        anchors.left: main.horizontalCenter
                        anchors.top: main.top
                    }
                }
            ]
        }
    }
}

