// SPDX-License-Identifier: GPL-3.0-or-later
#pragma once

#include <QObject>
#include <QString>

class RatioCalculator : public QObject {
  Q_OBJECT

public:
  enum Unit { Gallons, Liters, Milliliters };
  Q_ENUM(Unit)

  Q_PROPERTY(double totalVolume READ totalVolume WRITE setTotalVolume NOTIFY totalVolumeChanged)
  Q_PROPERTY(
      Unit totalUnit READ totalUnit WRITE setTotalUnit NOTIFY totalUnitChanged)
  Q_PROPERTY(double ratioA READ ratioA WRITE setRatioA NOTIFY ratioAChanged)
  Q_PROPERTY(double ratioB READ ratioB WRITE setRatioB NOTIFY ratioBChanged)

  Q_PROPERTY(double concentrate READ concentrate NOTIFY concentrateChanged)
  Q_PROPERTY(QString concentrateDisplay READ concentrateDisplay NOTIFY
                 concentrateDisplayChanged)
  Q_PROPERTY(QString error READ error NOTIFY errorChanged)

  explicit RatioCalculator(QObject *parent = nullptr);

  double totalVolume() const { return m_totalVolume; }
  void setTotalVolume(double v);

  Unit totalUnit() const { return m_totalUnit; }
  void setTotalUnit(Unit u);

  double ratioA() const { return m_ratioA; }
  void setRatioA(double v);

  double ratioB() const { return m_ratioB; }
  void setRatioB(double v);

  double concentrate() const { return m_concentrate; }
  QString concentrateDisplay() const { return m_concentrateDisplay; }
  QString error() const { return m_error; }

  Q_INVOKABLE void recalculate();
  Q_INVOKABLE void reset();

Q_SIGNALS:
  void totalVolumeChanged();
  void totalUnitChanged();
  void ratioAChanged();
  void ratioBChanged();
  void errorChanged();
  void concentrateChanged();
  void concentrateDisplayChanged();

private:
  double m_totalVolume = 0.0;
  Unit m_totalUnit = Gallons;
  double m_ratioA = 0.0;
  double m_ratioB = 0.0;

  double m_concentrate = 0.0;
  QString m_concentrateDisplay;
  QString m_error;
};
