// SPDX-License-Identifier: GPL-3.0-or-later
#include "ratiocalculator.h"

#include <QtGlobal>
#include <QLocale>

RatioCalculator::RatioCalculator(QObject *parent) : QObject(parent) {
  recalculate();
}

void RatioCalculator::setTotalVolume(double v) {
  if (qFuzzyCompare(m_totalVolume, v))
    return;
  m_totalVolume = v;
  Q_EMIT totalVolumeChanged();
  recalculate();
}

void RatioCalculator::setTotalUnit(Unit u) {
  if (m_totalUnit == u)
    return;
  m_totalUnit = u;
  Q_EMIT totalUnitChanged();
  recalculate();
}

void RatioCalculator::setRatioA(double v) {
  if (qFuzzyCompare(m_ratioA, v))
    return;
  m_ratioA = v;
  Q_EMIT ratioAChanged();
  recalculate();
}

void RatioCalculator::setRatioB(double v) {
  if (qFuzzyCompare(m_ratioB, v))
    return;
  m_ratioB = v;
  Q_EMIT ratioBChanged();
  recalculate();
}

void RatioCalculator::recalculate() {
  m_error.clear();

  if (!(m_totalVolume > 0.0)) {
    m_concentrate = 0.0;
    m_concentrateDisplay.clear();
    m_error = QStringLiteral("Total volume must be > 0");
    Q_EMIT errorChanged();
    return;
  }

  if (!(m_ratioA > 0.0) || !(m_ratioB > 0.0)) {
    m_concentrate = 0.0;
    m_concentrateDisplay.clear();
    m_error = QStringLiteral("Total volume must be > 0");
    Q_EMIT errorChanged();
    return;
  }

  const double totalParts = m_ratioA + m_ratioB;
  const double concentrate = m_totalVolume * (m_ratioB / totalParts);

  m_concentrate = concentrate;
  m_concentrateDisplay = QString::number(concentrate);

  Q_EMIT concentrateChanged();
  Q_EMIT concentrateDisplayChanged();
}

void RatioCalculator::reset() {
  m_totalVolume = 0.0;
  m_totalUnit = Gallons;
  m_ratioA = 0.0;
  m_ratioB = 0.0;
  m_concentrate = 0;
  m_concentrateDisplay.clear();
  m_error.clear();

  Q_EMIT totalVolumeChanged();
  Q_EMIT totalUnitChanged();
  Q_EMIT ratioAChanged();
  Q_EMIT ratioBChanged();
  Q_EMIT errorChanged();
  Q_EMIT concentrateDisplayChanged();
  Q_EMIT concentrateChanged();

  recalculate();
}
