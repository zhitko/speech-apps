#include "soundcontroller.h"

#include "filecontroller.h"
#include "services/sound/soundplayer.h"

#include <QDebug>

SoundController::SoundController(QObject *parent) : QObject(parent)
{

}

SoundController::~SoundController()
{

}

void SoundController::playFile(const QString fileName)
{
    qDebug() << "SoundController::playFile >> " << fileName;
    QString path = FileController::getUserFilesDir() + fileName;
    SoundPlayer * player = new SoundPlayer(path);
    player->start();
}
