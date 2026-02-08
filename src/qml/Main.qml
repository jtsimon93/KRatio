// SPDX-License-Identifier: GPL-3.0-or-later
import QtQuick
import org.kde.kirigami as Kirigami
import KRatio 1.0

Kirigami.ApplicationWindow {
    id: root
    width: 500
    height: 400

    title: qsTr("KRatio")

    pageStack.initialPage: RatioCalculatorPage {
	calc: Calc
    }

}
