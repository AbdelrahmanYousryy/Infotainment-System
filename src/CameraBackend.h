#ifndef CAMERA_BACKEND_H
#define CAMERA_BACKEND_H

#include <QObject>
#include <QProcess>
#include <QImage>
#include <QTimer>

class CameraBackend : public QObject
{
    Q_OBJECT
public:
    explicit CameraBackend(QObject *parent = nullptr);
    ~CameraBackend();

    Q_INVOKABLE void startCamera();  // Make this function invokable from QML
    Q_INVOKABLE void stopCamera();
    Q_INVOKABLE bool isCameraActive() const;

signals:
    void frameCaptured(const QImage &image);

private:
    bool cameraActive;
    QProcess *gstProcess;
    QTimer *captureTimer;
};

#endif // CAMERA_BACKEND_H
