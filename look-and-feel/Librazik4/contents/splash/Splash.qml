/*
 *   Copyright 2020 Mathieu PICOT <picotmathieu@gmail.com>
 *   With images from Elisa de Castro Guerra
 *   and from default breeze theme.
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5
import QtGraphicalEffects 1.0

Image {
    id: root
    source: "images/background.jpg"
    fillMode: Image.Tile
    
    property int stage
    
    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
            preOpacityAnimation.from = 0;
            preOpacityAnimation.to = 1;
            preOpacityAnimation.running = true;
        }
        if (stage == 4) {
            preOpacityAnimation.from = 1;
            preOpacityAnimation.to = 0;
            preOpacityAnimation.running = true;
            pausa.start();
        }
    }

    Item {
        id: content
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        opacity: 1
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: score_blue
            source: "images/LZK_score_blue.svg"
            x: (root.width / 2) - 255
            y: (root.height /2) - 74
        }
        
        Image {
            id: score
            fillMode : Image.Tile
            horizontalAlignment: Image.AlignLeft
            source: "images/LZK_score.svg"
            x: (root.width / 2) - 255
            y: (root.height / 2) - 74
            width: (sourceSize.width / 6) * (stage - 0.01)
            Behavior on width {
                PropertyAnimation {
                    duration: 500
                    easing.type: Easing.InOutQuad
                }
            }
        }
        
        Image {
            id: logo
            source: "images/LZK_top.svg"
            x: (root.width /2) - 255
            y: (root.height /2) - 74
        }
        
        Image {
            id: logo_blue
            source: "images/LZK_top_blue.svg"
            opacity: 0.65
            fillMode : Image.Tile
            horizontalAlignment: Image.AlignLeft
            x: (root.width /2) - 255
            y: (root.height /2) - 74
            width: (sourceSize.width / 6) * (stage - 0.01)
            
            Behavior on width {
                PropertyAnimation {
                    duration: 500
                    easing.type: Easing.InOutQuad
                }
            }
        }
        
        Image {
            source: "images/triangle.svg"
            anchors {
                bottom: parent.bottom
                right: parent.right}
            opacity: 0.7
        }
        
        /* Taken in breeze default splash */
        Row {
            spacing: units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: units.gridUnit
            }
            
            Text {
                color: "#eff0f1"
                // Work around Qt bug where NativeRendering breaks for non-integer scale factors
                // https://bugreports.qt.io/browse/QTBUG-67007
                renderType: Screen.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter
                text: i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "This is the first text the user sees while starting in the splash screen, should be translated as something short, is a form that can be seen on a product. Plasma is the project name so shouldn't be translated.", "Plasma made by KDE")
            }
            Image {
                source: "images/kde.svgz"
                sourceSize.height: units.gridUnit * 2
                sourceSize.width: units.gridUnit * 2
            }
        }
    }

    SequentialAnimation {
        id: introAnimation
        running: false
    }
}
