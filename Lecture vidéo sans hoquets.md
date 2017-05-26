#Lecture vidéo sans hoquets (et malheureusement sans son) avec un Raspberry PI 3

## Installer NOOBS sur la carte SD : https://www.raspberrypi.org/downloads/noobs/
## Insérer la carte SD dans le Raspberry PI 3
## Installer Raspbian
## Installer [Raspberry Pi Video Looper] (https://learn.adafruit.com/raspberry-pi-video-looper/installation)
```bash
    sudo apt-get update
    sudo apt-get install -y git
    git clone https://github.com/adafruit/pi_video_looper.git

    cd pi_video_looper
    sudo ./install.sh
```
## Désactiver le Raspberry Pi Video Looper
```bash
    sudo ./disable.sh
```