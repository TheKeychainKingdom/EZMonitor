
import QtQuick
import QtQuick.Layouts

import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami


PlasmoidItem {
    id:root

    property string p1: ""
    property string p2: ""
    property string summ: "0"


    Plasmoid.status: PlasmaCore.Types.ActiveStatus
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground

    Layout.minimumWidth: Kirigami.Units.gridUnit * 5
    Layout.minimumHeight: Kirigami.Units.gridUnit * 5

    implicitHeight: Kirigami.Units.gridUnit * 10
    implicitWidth: Kirigami.Units.gridUnit * 10

    function callback(x){

        if (x.responseText) {
            var d = JSON.parse(x.responseText);

            root.p1 = d.data.p1;
            root.p2 = d.data.p2;

            summ = (parseInt(root.p1)+parseInt(root.p2));

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
        repeat: true
        triggeredOnStart: true
        interval: 10000
        onTriggered: request('http://192.168.178.38:8050/getOutputData',callback)
    }


    // wtimer.start()

    ColumnLayout {

        PlasmaComponents.Label{
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            text:  i18n("Panel 1: "+root.p1+" Watt")
        }

        PlasmaComponents.Label{

            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            text: i18n("Panel 2: "+root.p2+" Watt")
        }

        PlasmaComponents.Label{
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap

            text: i18n("Total: "+summ+" Watt")
        }
    }
}