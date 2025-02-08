#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "src/MediaPlayerBackend.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // ✅ Register C++ Media Player Backend
    MediaPlayerBackend mediaBackend;
    engine.rootContext()->setContextProperty("mediaBackend", &mediaBackend);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
