
## Screen capture for old CRT-Monitor Signals
to replace old-monitor with minipc

capture framerate is slow ! no realtime ! 1/3 FPS

supportet signals
- Heidenhein TNC 150: SCREEN BE110

comming soon
- Sinumerik 810m
- ..


Prerequisites
- Operating System: Debian like OS
- xfce4-desktop or openbox
- min 2x CPU cores i3 2Ghz
- a Hardware USB Logic analyzer 8CH 24MHz !


install software on debian
execute as root
```
apt install sigrok-firmware-fx2lafw sigrok-cli 
apt install python3-pygame

# optional 
apt install sigrok pulseview
apt install screen

```



record a frame sample for archive
```
# read all screen frame from file recorded with
# self.cmd="sigrok-cli --driver=fx2lafw --channels D0=f,D1=h,D2=v --config samplerate=8m  --samples=1700k"
```

clone git repo
```
git clone https://github.com/flo932/crt-screen-video-grabber.git
```

start programm
```
cd crt-screen-video-grabber
python3 screen2.py

# optional startup script
sh start.sh
```


![MIKRON-HEIDENHEIN-TNC150](https://raw.githubusercontent.com/flo932/crt-screen-video-grabber/master/screenhot/2024-03-25_20-28-35.png "Virtual CRT")

![MIKRON-HEIDENHEIN-TNC150](https://raw.githubusercontent.com/flo932/crt-screen-video-grabber/master/screenhot/IMG_20240325_104117x.jpg "USB Logic Analyzer")

![MIKRON-HEIDENHEIN-TNC150](https://raw.githubusercontent.com/flo932/crt-screen-video-grabber/master/screenhot/IMG_20240322_153252x.jpg "OLD CNC CONTROLER, with Broken screen")

