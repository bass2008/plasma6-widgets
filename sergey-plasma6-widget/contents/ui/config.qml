/*
 * Copyright (C) 2024 by Heqro <heqromancer@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation;
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>
 */

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.core as PlasmaCore
import org.kde.kcmutils as KCM
import org.kde.iconthemes as KIconThemes
import org.kde.kirigami as Kirigami
import org.kde.ksvg as KSvg
import org.kde.plasma.components as PlasmaComponents

KCM.SimpleKCM {
    id: configPage

    property string cfg_iconA: configuration.iconA
    property string cfg_iconB: configuration.iconB

    property alias cfg_useExtraCommand_iconA: checkBox_iconA.checked
    property alias cfg_useExtraCommand_iconB: checkBox_iconB.checked

    property alias cfg_textField_iconA: textField_iconA.text
    property alias cfg_textField_iconB: textField_iconB.text
    property alias cfg_enableAutoSwitch: enableAutoSwitch.checked
    property alias cfg_dayStartTime: dayStartTime.text
    property alias cfg_nightStartTime: nightStartTime.text

    // HACK - this should be read from /package/contents/config/main.xml
    readonly property string default_iconA: 'semi-starred-symbolic'
    readonly property string default_iconB: 'semi-starred-symbolic-rtl'

    ColumnLayout {
        GridLayout {
            columns: 2

            Label {
                Layout.row: 0
                Layout.column: 0
                text: i18n("Icon A")
            }

            IconPicker {
                Layout.row: 0
                Layout.column: 1

                currentIconName: cfg_iconA
                defaultIconName: default_iconA
                formFactor: plasmoid.formFactor

                onCurrentIconNameChanged: cfg_iconA = currentIconName
            }

            Label {
                Layout.row: 1
                Layout.column: 0
                text: i18n("Icon B")
            }

            IconPicker {
                Layout.row: 1
                Layout.column: 1

                currentIconName: cfg_iconB
                defaultIconName: default_iconB
                formFactor: plasmoid.formFactor


                onCurrentIconNameChanged: cfg_iconB = currentIconName
            }

            CheckBox {
                id: checkBox_iconA
                Layout.row: 2
                Layout.column:0
                Layout.columnSpan:2
                text: i18n('Execute the following command when switching to icon A')
            }

            TextField {
                id: textField_iconA
                Layout.row: 3
                Layout.column:0
                Layout.columnSpan:2
                enabled: checkBox_iconA.checked
            }

            CheckBox {
                id: checkBox_iconB
                Layout.row: 4
                Layout.column:0
                Layout.columnSpan:2
                text: i18n('Execute the following command when switching to icon B')
            }

            TextField {
                id: textField_iconB
                Layout.row: 5
                Layout.column:0
                Layout.columnSpan:2
                enabled: checkBox_iconB.checked
            }
        }

        GroupBox {
            Layout.fillWidth: true
            title: i18n("Automatic Switching")

            ColumnLayout {
                CheckBox {
                    id: enableAutoSwitch
                    text: i18n("Enable automatic switching")
                }

                GridLayout {
                    columns: 2
                    enabled: enableAutoSwitch.checked

                    Label {
                        text: i18n("Day starts at:")
                    }
                    TextField {
                        id: dayStartTime
                        placeholderText: "06:00"
                        inputMask: "99:99"
                        text: plasmoid.configuration.dayStartTime
                    }

                    Label {
                        text: i18n("Night starts at:")
                    }
                    TextField {
                        id: nightStartTime
                        placeholderText: "18:00"
                        inputMask: "99:99"
                        text: plasmoid.configuration.nightStartTime
                    }
                }
            }
        }
    }
}
