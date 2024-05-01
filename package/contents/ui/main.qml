
import QtQuick
import QtQuick.Layouts

import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami


PlasmoidItem {
    id:root

    property string host: Plasmoid.configuration.Host //"192.168.178.38"
    property int    port: Plasmoid.configuration.Port //8050

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
        onTriggered: request('http://'+host+':'+port+'/getOutputData',callback)
    }

    // TODO: Plasmoid.fullRepresentation and  Plasmoid.compactRepresentation



    fullRepresentation: ColumnLayout {


        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter


        readonly property bool isVertical: {
            switch (Plasmoid.formFactor) {
                case PlasmaCore.Types.Planar:
                case PlasmaCore.Types.MediaCenter:
                case PlasmaCore.Types.Application:
                default:
                    if (root.height > root.width) {
                        return true;
                    } else {
                        return false;
                    }
                case PlasmaCore.Types.Vertical:
                    return true;
                case PlasmaCore.Types.Horizontal:
                    return false;
            }
        }

        width:  isVertical ? root.width : implicitWidth
        height: isVertical ? implicitHeight : root.height

        // flow:   isVertical ? GridLayout.TopToBottom : GridLayout.LeftToRight


        PlasmaComponents.Label{
            font: Kirigami.Theme.defaultFont
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: 5
            wrapMode: Text.Wrap
            text:  i18n("Panel 1: "+root.p1+" Watt")
        }

        PlasmaComponents.Label{
            font: Kirigami.Theme.defaultFont
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: 5
            wrapMode: Text.Wrap
            text: i18n("Panel 2: "+root.p2+" Watt")
        }

        PlasmaComponents.Label{
            font: Kirigami.Theme.defaultFont
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: 5
            wrapMode: Text.Wrap

            text: i18n("Total: "+summ+" Watt")
        }
    }

}