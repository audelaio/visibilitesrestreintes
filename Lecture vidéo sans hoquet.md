# Lecture vidéo sans hoquet (et malheureusement sans son) avec un Raspberry PI 3

* Installer [NOOBS](https://www.raspberrypi.org/downloads/noobs/) sur la carte SD
* Insérer la carte SD dans le Raspberry PI 3
* Installer Raspbian
* Installer [Raspberry Pi Video Looper](https://learn.adafruit.com/raspberry-pi-video-looper/installation) avec un terminal
```bash
    cd
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
* Sur votre ordinateur, exporter la vidéo en **H.264** 
* Sur votre ordinateur, convertir la vidéo en **raw H.264 stream** avec [ffmpeg](https://www.ffmpeg.org/) avec la commande suivante en substituant _input_file.mov_ et _output_file.h264_ pour les bons noms
```bash
    ffmpeg -i input_file.mov -vcodec copy -an -bsf:v h264_mp4toannexb output_file.h264
```
* De retour sur Raspberry Pi, lancer la lecture de la vidéo avec **hello_video**
```bash
    hello_video --loop output_file.h264
```

