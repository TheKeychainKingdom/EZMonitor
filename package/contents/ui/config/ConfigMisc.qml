import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2

import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {

    property string cfg_Host
    property int cfg_Port


    onCfg_PortChanged: {
        updatePortnumberSpinBox.value = updatePortnumberSpinBox.cfg_Port;
    }


    Kirigami.FormLayout {

        QQC2.SpinBox {
            id: updatePortnumberSpinBox

            Kirigami.FormData.label: "Change Port:"

            stepSize: 1
            from: 1
            to: 1023

            validator: IntValidator {
                bottom: updatePortnumberSpinBox.from
                top: updatePortnumberSpinBox.to
            }


            onValueChanged: cfg_Port = value

        }

    }
}
