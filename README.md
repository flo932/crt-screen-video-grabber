
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

```



record a frame sample for archive
```
# read all screen frame from file recorded with
# self.cmd="sigrok-cli --driver=fx2lafw --channels D0=f,D1=h,D2=v --config samplerate=8m  --samples=1700k"
```
