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


import QtQuick 2.2
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

Label {
    property string message
    property string fontFamily
    property bool bold
    property bool italic
    property int fontColor_A
    property int fontColor_R
    property int fontColor_G
    property int fontColor_B
    property double fontSize

    function rgbToHex(R, G, B) { return "#" + toHex(R) + toHex(G) + toHex(B) }
    function toHex(n) {
        n = parseInt(n, 10);
        if (isNaN(n)) return "00";
        n = Math.max(0, Math.min(n, 255));
        return "0123456789ABCDEF".charAt((n - n % 16) / 16) + "0123456789ABCDEF".charAt(n % 16);
    }
    wrapMode: Label.WrapAtWordBoundaryOrAnywhere
    id: thisLabel
    text: message
    font.family: fontFamily
    font.pixelSize: fontSize
    font.bold: bold
    font.italic: italic
    color: rgbToHex(fontColor_R, fontColor_G, fontColor_B)
}
