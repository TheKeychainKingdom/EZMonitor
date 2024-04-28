import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

QQC2.Pane {
    id: root

    property alias cfg_BoolTest: testBoolConfigField.checked
    property alias cfg_Test: testConfigField.text
    property alias cfg_IntTest: intTestConfigField.value

    Kirigami.FormLayout {
        anchors.fill: parent

        QQC2.CheckBox {
            id: testBoolConfigField
            text: i18nc("@label example config", "Bool from config")
            Kirigami.FormData.label: i18nc("@label example config", "Bool Config value:")
        }
        QQC2.TextField {
            id: testConfigField
            placeholderText: i18nc("@label example config", "String test")
            Kirigami.FormData.label: i18nc("@label example config", "Text Config value:")
        }
        QQC2.SpinBox {
            id: intTestConfigField
            Kirigami.FormData.label: i18nc("@label example config", "Integer:")
            from: -1
            to: 100
        }
    }
}
