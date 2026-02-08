// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import KRatio 1.0

Kirigami.ScrollablePage {
    id: ratioCalculatorPage
    property QtObject calc: null

    title: qsTr("Ratio Calculator")

    ColumnLayout {
	Layout.fillWidth: true
	Layout.fillHeight: true
	spacing: Kirigami.Units.largeSpacing
	
	ColumnLayout {
	    Layout.fillWidth: true
	    
	    Controls.Label {
		text: qsTr("Total Volume")
	    }

	    RowLayout {
		Layout.fillWidth: true
		
		Controls.TextField {
		    id: totalVolumeTextField
		    Layout.fillWidth: true
		    placeholderText: qsTr("e.g. 1.0")

		    Component.onCompleted: {
			if(calc)
			    text = calc.totalVolume > 0 ? String(calc.totalVolume) : ""
			else
			    text = ""
		    }

		    onEditingFinished: {
			if (!calc) return
			const v = Number(text)
			calc.totalVolume = isNaN(v) ? 0 : v
		    }
		}
		
		// Keep UI synced
		Connections {
		    target: calc ? calc : null
		    
		    function onTotalVolumeChanged() {
			totalVolumeTextField.text = calc.totalVolume > 0 ? String(calc.totalVolume) : ""
		    }

		}
		

		Controls.ComboBox {
		    id: totalVolumeUnitComboBox
		    model: ["Gallons", "Liters", "Milliliters"]
		    Layout.preferredWidth: Kirigami.Units.gridUnit * 8
		    currentIndex: calc ? calc.totalUnit : 0
		    onCurrentIndexChanged: {
			if(calc) {
			    calc.totalUnit = currentIndex
			}
		    }
		}
	    }
	    

	    Kirigami.Separator {
		Layout.fillWidth: true
	    }

	    ColumnLayout {
		Layout.fillWidth: true
		
		Controls.Label {
		    text: qsTr("Ratio")
		}
		
		RowLayout {
		    Layout.fillWidth: true
		    
		    Controls.TextField {
			id: diluentRatioTextField
			Layout.preferredWidth: Kirigami.Units.gridUnit * 8
			inputMethodHints: Qt.ImhDigitsOnly
			horizontalAlignment: TextInput.AlignHCenter

			Component.onCompleted: text = calc.ratioA > 0 ? String(calc.ratioA) : ""

			onEditingFinished: {
			    const v = Number(text)
			    calc.ratioA = isNaN(v) ? 0 : v
			}

			Connections {
			    target: calc
			    function onTotalVolumeChanged() {
				diluentRatioTextField.text = calc.ratioA > 0 ? String(calc.ratioA) : ""
			    }
			}
		    }

		    Controls.Label {
			text: ":"
			Layout.alignment: Qt.AlignVCenter
		    }

		    Controls.TextField {
			id: concentrateRatioTextField
			Layout.preferredWidth: Kirigami.Units.gridUnit * 8
			inputMethodHints: Qt.ImhDigitsOnly
			horizontalAlignment: TextInput.AlignHCenter

			Component.onCompleted: text = calc.ratioB > 0 ? String(calc.ratioB) : ""

			onEditingFinished: {
			    const v = Number(text)
			    calc.ratioB = isNaN(v) ? 0 : v
			}

			Connections {
			    target: calc
			    function onRatioBChanged() {
				concentrateRatioTextField.text = calc.ratioB > 0 ? String(calc.ratioB) : ""
			    }
			}
		    }
		}
	    }
	    
	    Kirigami.Separator {
		Layout.fillWidth: true
	    }

	    Kirigami.Card {
		id: resultCard
		Layout.fillWidth: true

		contentItem: ColumnLayout {
		    Layout.fillWidth: true
		    
		    Controls.Label { text: qsTr("Concentrate Needed") }

		    Controls.Label {
			id: resultLabel
			font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.6
			text: calc ? calc.concentrateDisplay : ""
		    }

		    Controls.Label {
			id: secondaryResultLabel
			font.pixelSize: Kirigami.Theme.defaultFont.pixelSize;
			color: "gray"
			text: calc ? calc.secondaryConcentrateDisplay: ""
		    }

		    Connections {
			target: calc
			function onConcentrateDisplayChanged() {
			    resultLabel.text = calc.concentrateDisplay
			}

			function onSecondaryConcentrateDisplayChanged() {
			    secondaryResultLabel.text = calc.secondaryConcentrateDisplay
			}
		    }
		}
	    }

	    Kirigami.Separator {
		Layout.fillWidth: true
	    }

	    RowLayout {
		Layout.fillWidth: true
		
		Controls.Button {
		    text: qsTr("Swap Units")
		    onClicked: {
			const temp = diluentRatioTextField.text
			diluentRatioTextField.text = concentrateRatioTextField.text
			concentrateRatioTextField.text = temp

			calc.ratioA = diluentRatioTextField.text
			calc.ratioB = concentrateRatioTextField.text
		    }
		}

		Controls.Button {
		    text: qsTr("Reset")
		    onClicked: {
			calc.reset()
		    }
		}
	    }
	}
    }
}
