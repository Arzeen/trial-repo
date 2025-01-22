#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Controllers/wifimanager.h"
#include "Controllers/systemcontroller.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<SystemController>("Shadaan",1,0,"SystemController");
    qmlRegisterType<WifiManager>("Shadaan", 1, 0, "WifiManager");
    WifiManager wifiManager;
    QQmlApplicationEngine engine;

     engine.rootContext()->setContextProperty("wifiManager", &wifiManager);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("CopyThermostatExample", "Main");

    return app.exec();
}
