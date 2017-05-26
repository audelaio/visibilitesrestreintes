# Lecture vidéo sans hoquets (et malheureusement sans son) avec un Raspberry PI 3

* Installer [NOOBS] (https://www.raspberrypi.org/downloads/noobs/) sur la carte SD
* Insérer la carte SD dans le Raspberry PI 3
* Installer Raspbian
* Installer [Raspberry Pi Video Looper] (https://learn.adafruit.com/raspberry-pi-video-looper/installation)
```bash
    sudo apt-get update
    sudo apt-get install -y git
    git clone https://github.com/adafruit/pi_video_looper.git

    cd pi_video_looper
    sudo ./install.s
```
* Désactiver le Raspberry Pi Video Looper (on va utiliser les outils installés par le script sans utiliser le Video Looper en tant que tel)
```bash
    sudo ./disable.sh
```
