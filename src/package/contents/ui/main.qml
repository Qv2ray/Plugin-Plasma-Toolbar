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
 
import QtQuick 2.7
import QtQuick.Layouts 1.13
import QtQml.Models 2.13
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

Item {
    id: main
    Plasmoid.switchWidth: units.gridUnit * 2
    Plasmoid.switchHeight: units.gridUnit * 2
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: Item{
        function processData(data){
            var item = {}
            try
            {
                item = JSON.parse(data);
                if(item === null)
                {
                    console.warn("Json Processing error, this may happen sometimes.")
                    return;
                }
            }
            catch (e) {
                console.warn(e)
                return;
            }

            if(stackLayoutMain.count !== item.Pages.length) {
                // Stack layout data outdated, so we need reset it.
                console.log("Reconstructing StackLayout")
                console.log("Pages Count: " + item.Pages.length)
                console.log("Stack Count: " + stackLayoutMain.count)
                // Remove all pages.
                for(var i = stackLayoutMain.count; i > 0 ; i--) {
                    console.log("destroying: " + i)
                    stackLayoutMain.children[i-1].destroy()
                }

                // Add new pages.
                for (var index = 0; index < item.Pages.length; index++) {
                    console.log("Adding new page in stacked list.")
                    var _page = Qt.createComponent("QvBarPage.qml")
                    var obj = _page.createObject(stackLayoutMain);
                    if (obj === null) {
                        console.error("Stack not ready.." + _page.errorString())
                    }
                }
            }
            //
            for (var _index = 0; _index < item.Pages.length; _index++) {
                var pageItem = stackLayoutMain.itemAt(_index);
                pageItem.loadContent(item.Pages[_index])
            }

        }
        Layout.minimumWidth: 100 // FIXME: use above
        //Layout.minimumHeight: 256
        Component.onCompleted: {
            plasmoid.removeAction("configure");
        }

        MouseArea {
            id: mouseAreaClientSetup
            anchors.fill: parent
            onClicked: {
                stackLayoutMain.currentIndex = (stackLayoutMain.currentIndex + 1) % stackLayoutMain.count
                console.log("Current Stack ID: " + stackLayoutMain.currentIndex)
            }
        }

        StackLayout {
            id: stackLayoutMain
            anchors.fill: parent
            currentIndex: 0
        }

        PlasmaCore.DataSource {
            id: dataSource
            engine: 'systemmonitor'

            connectedSources: [ 'system/uptime' ]

            onNewData: {
                processData(plasmoid.nativeInterface.data)
            }
            interval: 1000
        }
        Plasmoid.fullRepresentation: Plasmoid.compactRepresentation
    }
}
