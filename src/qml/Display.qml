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
import Nemo
import "calculator.js" as CalcEngine

Item {
    Text {
        id: displayText
        text: calcwindow.displayText.length > 0 ? calcwindow.displayText : calcwindow.displayPrevious
        color: Theme.accentColor;
        smooth: true;
        font.bold: true
        Component.onCompleted: refitText()
        horizontalAlignment: Text.AlignRight;
        verticalAlignment: Text.AlignVCenter;
        anchors {
            right: leftArrowButton.left
            rightMargin: 6
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }

        property int minimumSize: 42

        onWidthChanged: refitText()
        onHeightChanged: refitText()
        onTextChanged: refitText()

        function refitText() {
            if (paintedHeight == -1 || paintedWidth == -1)
                return

            while (paintedWidth > width || paintedHeight > height) {
                if (--font.pixelSize <= minimumSize || font.pixelSize <= 0)
                    break
            }

            while (paintedWidth < width && paintedHeight < height) {
                font.pixelSize++

            }

            // sanity cap
            if (font.pixelSize >= 120) {
                font.pixelSize = 120
                return
            }

            font.pixelSize--
        }
    }

    Image {
        id: leftArrowButton
        source: "image://theme/chevron-left"

        anchors {
            right: parent.right; rightMargin: 6
            verticalCenter: parent.verticalCenter;
            verticalCenterOffset: -1
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                doOp(CalcEngine.leftArrow)
            }
        }


        Shortcut {
            id: shortcutItem
            context: Qt.ApplicationShortcut
            sequence: "Backspace"
            onActivated: {
                doOp(CalcEngine.leftArrow)
            }
        }

    }
}
