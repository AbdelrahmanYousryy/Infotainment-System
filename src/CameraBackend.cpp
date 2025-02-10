#include "CameraBackend.h"
#include <QProcess>
#include <QImage>
#include <QTimer>
#include <QDebug>

CameraBackend::CameraBackend(QObject *parent) : QObject(parent), cameraActive(false), gstProcess(nullptr)
{
    captureTimer = new QTimer(this);
    connect(captureTimer, &QTimer::timeout, this, [this]() {
        // Simulate frame capture (replace with actual frame capture logic)
        QImage img(640, 480, QImage::Format_RGB888);  // Dummy image
        img.fill(Qt::black);  // Dummy black frame
        emit frameCaptured(img);  // Emit the dummy frame to QML
    });
}

CameraBackend::~CameraBackend()
{
    stopCamera();
}

void CameraBackend::startCamera()
{
    if (cameraActive)
        return;

    gstProcess = new QProcess(this);

    // ✅ Correct GStreamer pipeline for MJPG-supported cameras
    QString pipeline = "gst-launch-1.0 v4l2src device=/dev/video0 ! image/jpeg ! jpegdec ! autovideosink";

    gstProcess->start(pipeline);

    if (!gstProcess->waitForStarted()) {
        qDebug() << "Error: GStreamer failed to start.";
        return;
    }

    cameraActive = true;
    qDebug() << "✅ Camera started successfully!";
}

void CameraBackend::stopCamera()
{
    if (!cameraActive)
        return;

    captureTimer->stop();
    if (gstProcess && gstProcess->state() == QProcess::Running)
        gstProcess->terminate();

    cameraActive = false;
    qDebug() << "Camera stopped";
}

bool CameraBackend::isCameraActive() const
{
    return cameraActive;
}
