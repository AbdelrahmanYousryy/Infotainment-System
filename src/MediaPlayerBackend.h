#ifndef MEDIAPLAYERBACKEND_H
#define MEDIAPLAYERBACKEND_H

#include <QObject>
#include <QMediaPlayer>

class MediaPlayerBackend : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool isPlaying READ isPlaying NOTIFY stateChanged)

public:
    explicit MediaPlayerBackend(QObject *parent = nullptr);

    Q_INVOKABLE QStringList getSongs();  // ✅ Returns available songs
    Q_INVOKABLE void playMedia(const QString &filename);
    Q_INVOKABLE void pauseMedia();
    Q_INVOKABLE void stopMedia();

    bool isPlaying();
    Q_INVOKABLE void resumeMedia();

signals:
    void stateChanged();

private:
    QMediaPlayer *player;
    QString currentSong;
};

#endif // MEDIAPLAYERBACKEND_H
