/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QML Presentation System.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/


import QtQuick 2.0

Slide {
    id: slide

    property variant leftContent: []
    property variant rightContent: []
    property string leftCenteredText
    property string rightCenteredText

    Column {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width / 2

        Repeater {
            model: slide.leftContent.length

            Row {
                id: leftRow

                function decideIndentLevel(s) { return s.charAt(0) == " " ? 1 + decideIndentLevel(s.substring(1)) : 0 }
                property int indentLevel: decideIndentLevel(slide.leftContent[index])
                property int nextIndentLevel: index < slide.leftContent.length - 1 ? decideIndentLevel(slide.leftContent[index+1]) : 0
                property real indentFactor: (10 - leftRow.indentLevel * 2) / 10;

                height: text.height + (nextIndentLevel == 0 ? 1 : 0.3) * slide.baseFontSize * slide.bulletSpacing
                x: slide.baseFontSize * indentLevel
                visible: (!slide.parent.allowDelay || !delayPoints) || index <= _pointCounter

                Rectangle {
                    id: dot
                    anchors.baseline: text.baseline
                    anchors.baselineOffset: -text.font.pixelSize / 2
                    width: text.font.pixelSize / 3
                    height: text.font.pixelSize / 3
                    color: slide.textColor
                    radius: width / 2
                    opacity: text.text.length == 0 ? 0 : 1
                }

                Item {
                    id: space
                    width: dot.width * 1.5
                    height: 1
                }

                Text {
                    id: text
                    width: slide.contentWidth - parent.x - dot.width - space.width
                    font.pixelSize: baseFontSize * leftRow.indentFactor
                    text: slide.leftContent[index]
                    textFormat: slide.textFormat
                    wrapMode: Text.WordWrap
                    color: slide.textColor
                    horizontalAlignment: Text.AlignLeft
                    font.family: slide.fontFamily
                }
            }
        }
    }

    Column {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: parent.width / 2

        Repeater {
            model: slide.rightContent.length

            Row {
                id: rightRow

                function decideIndentLevel(s) { return s.charAt(0) == " " ? 1 + decideIndentLevel(s.substring(1)) : 0 }
                property int indentLevel: decideIndentLevel(slide.rightContent[index])
                property int nextIndentLevel: index < slide.rightContent.length - 1 ? decideIndentLevel(slide.rightContent[index+1]) : 0
                property real indentFactor: (10 - rightRow.indentLevel * 2) / 10;

                height: text.height + (nextIndentLevel == 0 ? 1 : 0.3) * slide.baseFontSize * slide.bulletSpacing
                x: slide.baseFontSize * indentLevel
                visible: (!slide.parent.allowDelay || !delayPoints) || index <= _pointCounter

                Rectangle {
                    id: dot
                    anchors.baseline: text.baseline
                    anchors.baselineOffset: -text.font.pixelSize / 2
                    width: text.font.pixelSize / 3
                    height: text.font.pixelSize / 3
                    color: slide.textColor
                    radius: width / 2
                    opacity: text.text.length == 0 ? 0 : 1
                }

                Item {
                    id: space
                    width: dot.width * 1.5
                    height: 1
                }

                Text {
                    id: text
                    width: slide.contentWidth - parent.x - dot.width - space.width
                    font.pixelSize: baseFontSize * rightRow.indentFactor
                    text: slide.rightContent[index]
                    textFormat: slide.textFormat
                    wrapMode: Text.WordWrap
                    color: slide.textColor
                    horizontalAlignment: Text.AlignLeft
                    font.family: slide.fontFamily
                }
            }
        }
    }
}
