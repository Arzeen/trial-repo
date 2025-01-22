#include "wifimanager.h"
#include <QProcess>
#include <QDebug>

WifiManager::WifiManager(QObject *parent)
    : QObject(parent),
      process(new QProcess(this)),
      m_selectedNetwork("")  // Initialize m_selectedNetwork here
{
}

QStringList WifiManager::getAvailableNetworks()
{
    QStringList networks;

    // Start the netsh process to scan for available Wi-Fi networks
    process->start("netsh", QStringList() << "wlan" << "show" << "networks");
    process->waitForFinished();

    // Read the output of the process
    QString output = process->readAllStandardOutput();
    QStringList lines = output.split("\n");

    // Parse the output to find the network names
    for (const QString &line : lines) {
        if (line.startsWith("SSID")) {
            QString ssid = line.split(":").at(1).trimmed();
            if (!ssid.isEmpty()) {
                networks.append(ssid);
            }
        }
    }

    return networks;
}
void WifiManager::connectToNetwork(const QString &ssid, const QString &password)
{
    // Store the selected network SSID
    m_selectedNetwork = ssid;

    // Validate password
    if (password.isEmpty()) {
        qDebug() << "Password is empty. Cannot connect to network:" << ssid;
        return;
    }

    // Step 1: Delete any existing saved profile for the network
    QString deleteProfileCommand = QString("netsh wlan delete profile name=\"%1\"").arg(ssid);
    process->start(deleteProfileCommand);
    process->waitForFinished();

    // Step 2: Attempt to connect to the network with the provided password
    QString connectCommand = QString("netsh wlan connect name=\"%1\"").arg(ssid);
    process->start(connectCommand);
    process->waitForFinished();

    QString connectResult = process->readAllStandardOutput();

    // Step 3: Check if the connection was successful
    if (connectResult.contains("Connection request was completed successfully")) {
        qDebug() << "Successfully connected to network:" << ssid;
    } else {
        qDebug() << "Failed to connect to network:" << ssid;

        // Check if the failure is due to password issues or other reasons
        if (connectResult.contains("bad password") || connectResult.contains("WPA2")) {
            qDebug() << "Incorrect password for network:" << ssid;
        } else {
            qDebug() << "Other error during connection attempt.";
        }
    }
}



// Helper function to create the profile XML (SSID + password)
QString WifiManager::createProfileXML(const QString &ssid, const QString &password)
{
    QString xmlTemplate = 
        "<?xml version=\"1.0\"?>"
        "<WLANProfile xmlns=\"http://www.microsoft.com/networking/WLAN/profile/v1\">"
        "<name>%1</name>"
        "<SSIDConfig>"
        "<SSID>"
        "<name>%1</name>"
        "</SSID>"
        "</SSIDConfig>"
        "<connectionType>ESS</connectionType>"
        "<connectionMode>auto</connectionMode>"
        "<authentication>WPA2PSK</authentication>"
        "<encryption>AES</encryption>"
        "<sharedKey>"
        "<keyType>passPhrase</keyType>"
        "<keyMaterial>%2</keyMaterial>"
        "</sharedKey>"
        "</WLANProfile>";

    return xmlTemplate.arg(ssid).arg(password);
}

QString WifiManager::selectedNetwork() const
{
    return m_selectedNetwork;
}

void WifiManager::setSelectedNetwork(const QString &network)
{
    if (m_selectedNetwork != network) {
        m_selectedNetwork = network;
        emit selectedNetworkChanged();
    }
}
