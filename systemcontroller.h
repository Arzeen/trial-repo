#ifndef SYSTEMCONTROLLER_H
#define SYSTEMCONTROLLER_H

#include <QObject>

class SystemController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int currentSystemTemperature READ currentSystemTemperature WRITE setCurrentSystemTemperature NOTIFY currentSystemTemperatureChanged FINAL)
    Q_PROPERTY(int targetTemp READ targetTemp WRITE setTargetTemp NOTIFY targetTempChanged FINAL)
    Q_PROPERTY(QString systemStatusMessage READ systemStatusMessage WRITE setSystemStatusMessage NOTIFY systemStatusMessageChanged FINAL)
    Q_PROPERTY(HeatSelectState systemState READ systemState WRITE setSystemState NOTIFY systemStateChanged FINAL)
    Q_PROPERTY(QString systemUnits READ systemUnits WRITE setSystemUnits NOTIFY systemUnitsChanged FINAL)

public:
    explicit SystemController(QObject *parent = nullptr);

    enum HeatSelectState{
        HEATING,
        COOLING,
        AUTO
    };

    Q_ENUM(HeatSelectState)
    int currentSystemTemperature() const;

    int targetTemp() const;

    QString systemStatusMessage() const;

    HeatSelectState systemState() const;

    QString systemUnits() const;

public slots:
    void setCurrentSystemTemperature(int newCurrentSystemTemperature);
    void setTargetTemp(int newTargetTemp);
    void setSystemStatusMessage(const QString &newSystemStatusMessage);
    void setSystemState(HeatSelectState newSystemState);
    void setSystemUnits(const QString &newSystemUnits);

signals:
    void currentSystemTemperatureChanged();
    void targetTempChanged();

    void systemStatusMessageChanged();

    void systemStateChanged();

    void systemUnitsChanged();

private:
    void checkSystemStatus();
    int m_currentSystemTemperature;
    int m_targetTemp;
    QString m_systemStatusMessage;
    HeatSelectState m_systemState;
    QString m_systemUnits;
};

#endif // SYSTEMCONTROLLER_H
