#ifndef WIFIMANAGER_H
#define WIFIMANAGER_H

#include <QObject>
#include <QStringList>
#include <QProcess>

class WifiManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString selectedNetwork READ selectedNetwork WRITE setSelectedNetwork NOTIFY selectedNetworkChanged)

public:
    explicit WifiManager(QObject *parent = nullptr);

    // Function to get available Wi-Fi networks
    Q_INVOKABLE QStringList getAvailableNetworks();

    // Function to connect to a Wi-Fi network using SSID and password
    Q_INVOKABLE void connectToNetwork(const QString &ssid, const QString &password);

    // Getter and Setter for selectedNetwork
    QString selectedNetwork() const;
    void setSelectedNetwork(const QString &network);
    // Add this declaration inside the WifiManager class
QString createProfileXML(const QString &ssid, const QString &password);


signals:
    // Signal to notify when selected network changes
    void selectedNetworkChanged();

private:
    QProcess *process;  // Used to run system commands (e.g., netsh)
    QString m_selectedNetwork;  // Stores the selected network SSID
};

#endif // WIFIMANAGER_H
