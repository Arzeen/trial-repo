cmake_minimum_required(VERSION 3.16)

project(CopyThermostatExample VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)               #must have for QML to work
set(CMAKE_AUTORCC ON)               #for compiling qrc file to rcc
set(AUTORCC_OPTIONS "src/qml.qrc")

find_package(Qt6 REQUIRED COMPONENTS Quick Network)
qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appCopyThermostatExample
    main.cpp
)

qt_add_qml_module(appCopyThermostatExample
    URI CopyThermostatExample
    VERSION 1.0
    QML_FILES
        Main.qml

        RESOURCES qml.qrc
        QML_FILES UI/HomeScreen/HomeScreen.qml
        QML_FILES UI/HomeScreen/TemperatureControlSlider.qml
        QML_FILES UI/HomeScreen/HeatSelectDialog.qml
        QML_FILES UI/SettingsScreen/AboutPage.qml
        QML_FILES UI/SettingsScreen/settingScreen.qml
        QML_FILES UI/SettingsScreen/SettingsMainMenu.qml
        QML_FILES UI/SettingsScreen/UnitsPage.qml
        SOURCES Controllers/systemcontroller.h Controllers/systemcontroller.cpp
        SOURCES Controllers/wifimanager.h Controllers/wifimanager.cpp
        QML_FILES UI/SettingsScreen/WifiDialog.qml
        SOURCES Controllers/wifimanager.h Controllers/wifimanager.cpp


)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appCopyThermostatExample PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appCopyThermostatExample
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appCopyThermostatExample
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Network
)

include(GNUInstallDirs)
install(TARGETS appCopyThermostatExample
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
