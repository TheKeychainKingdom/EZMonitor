/*
 *   SPDX-FileCopyrightText: 2023 Oliver Beard <olib141@outlook.com>
 *   SPDX-License-Identifier: MIT
 */

import QtQuick
import QtQuick.Layouts

import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami


// PlasmoidItem {
//     Layout.minimumWidth: Kirigami.Units.gridUnit * 5
//     Layout.minimumHeight: Kirigami.Units.gridUnit * 5
//
//     implicitHeight: Kirigami.Units.gridUnit * 10
//     implicitWidth: Kirigami.Units.gridUnit * 10
//
//     PlasmaComponents.Label {
//         anchors.fill: parent
//         wrapMode: Text.Wrap
//         text: i18n("Hello world")
//     }
// }



PlasmoidItem {
    id:root


    property string p1: ""
    property string p2: ""

    Layout.minimumWidth: Kirigami.Units.gridUnit * 5
    Layout.minimumHeight: Kirigami.Units.gridUnit * 5

    implicitHeight: Kirigami.Units.gridUnit * 10
    implicitWidth: Kirigami.Units.gridUnit * 10

    function callback(x){
        if (x.responseText) {
            var d = JSON.parse(x.responseText);

            root.p1 = d.data.p1;
            root.p2 = d.data.p2;
        }
    }

    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = (function f() {callback(xhr)});
        xhr.open('GET', url, true);
        xhr.send();
    }


    Timer {
        running: true
        triggeredOnStart: true
        interval: 60000
        onTriggered: request('http://192.168.178.38:8050/getOutputData',callback)
    }

    Rectangle {
        color: "#0f0" // white
         Layout.fillHeight: true
         Layout.fillWidth: true

         }

    ColumnLayout {


        PlasmaComponents.Label{

            Text {  text:  i18n("Panel 1: "+root.p1+" Watt")}

        }

        PlasmaComponents.Label{

            Text {  text: "Panel 2: "+root.p2+" Watt"}

        }

    }
}