#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "src/MediaPlayerBackend.h"
#include "src/CameraBackend.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // ✅ Register C++ Media Player Backend
    MediaPlayerBackend mediaBackend;
    engine.rootContext()->setContextProperty("mediaBackend", &mediaBackend);


    // Create the context for the QML engine and pass the CameraBackend object
    CameraBackend cameraBackend;  // Create the camera backend object
    // Expose the cameraBackend to QML
    engine.rootContext()->setContextProperty("cameraBackend", &cameraBackend);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
