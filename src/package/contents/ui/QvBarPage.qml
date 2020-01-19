/*
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http: //www.gnu.org/licenses/>.
 */

import QtQuick 2.1
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

import "./"

Item {
    function loadContent(data) {
        if (data.Lines.length !== lineList.children.length)
        {
            console.log("Reconstructing Lines")
            console.log("data Lines: " + data.Lines.length)
            console.log("Column size: " + lineList.children.length)
            for(var i = lineList.children.length; i > 0 ; i--) {
                console.log("Destroying: " + i)
                lineList.children[i-1].destroy()
            }
            for(var i = 0; i < data.Lines.length ; i++) {
                console.log("Creating line: " + i)
                var _page = Qt.createComponent("QvBarLine.qml")
                var obj = _page.createObject(lineList);
                if (obj === null) {
                    console.log("Line not ready.." + _page.errorString())
                }
            }
        }

        for (var i = 0; i < data.Lines.length; i++) {
            var Jline = data.Lines[i]
            var Iline = lineList.children[i]
            Iline.bold = Jline.Bold === undefined ? true : Jline.Bold
            Iline.italic = Jline.Italic === undefined ? false : Jline.Italic
            Iline.fontSize = Jline.Size === undefined ? 12 : Jline.Size
            Iline.fontFamily = Jline.Family === undefined ? "Consolas" : Jline.Family
            Iline.fontColor_A = Jline.ColorA === undefined ? 255 : Jline.ColorA
            Iline.fontColor_R = Jline.ColorR === undefined ? 255 : Jline.ColorR
            Iline.fontColor_G = Jline.ColorG === undefined ? 255 : Jline.ColorG
            Iline.fontColor_B = Jline.ColorB === undefined ? 255 : Jline.ColorB
            Iline.message = Jline.Message
        }

    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        id: lineList
    }
}
