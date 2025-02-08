#include "MediaPlayerBackend.h"
#include <QDir>  // ✅ Ensure QDir is included
#include <QDebug>
#include <QCoreApplication>

MediaPlayerBackend::MediaPlayerBackend(QObject *parent) : QObject(parent) {
    player = new QMediaPlayer(this);
    player->setVolume(100);  // ✅ Set volume to max
}

// ✅ Implement `getSongs()`
QStringList MediaPlayerBackend::getSongs() {
    QString musicFolder = "/home/yousry/InfotainmentGUI/songs";
    QDir directory(musicFolder);

    if (!directory.exists()) {
        qDebug() << "❌ Songs folder does not exist: " << musicFolder;
        return QStringList();
    }

    QStringList filters;
    filters << "*.mp3" << "*.wav"; // ✅ Only show audio files
    QStringList songList = directory.entryList(filters, QDir::Files);

    qDebug() << "✅ Songs found:" << songList;
    return songList;
}

// ✅ Ensure `playMedia()` is correctly implemented
void MediaPlayerBackend::playMedia(const QString &filename) {
    if (filename.isEmpty()) {
            qDebug() << "Error: No song selected!";
            return;
        }
    // ✅ Save the last played song
     currentSong = filename;

    QString filePath = "/home/yousry/InfotainmentGUI/songs/" + filename;
    qDebug() << "Playing media:" << filePath;

    player->setMedia(QUrl::fromLocalFile(filePath));

    if (player->mediaStatus() == QMediaPlayer::NoMedia) {
        qDebug() << "❌ ERROR: No media loaded!";
    }

    player->play();
}

// ✅ Pause & Stop functions
void MediaPlayerBackend::pauseMedia() {
    if (player->state() == QMediaPlayer::PlayingState) {
            player->pause();
        }
 //   player->pause();
    emit stateChanged();
}

void MediaPlayerBackend::stopMedia() {
    player->stop();
    emit stateChanged();
}

bool MediaPlayerBackend::isPlaying() {
    return player->state() == QMediaPlayer::PlayingState;
}

void MediaPlayerBackend::resumeMedia() {
    if (!currentSong.isEmpty()) {
        playMedia(currentSong);  // ✅ Resume last song instead of restarting
    } else {
        qDebug() << "Error: No last song available!";
    }
}
