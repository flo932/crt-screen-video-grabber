#!/usr/bin/sh

cd /home/$USER/crt-screen-video-grabber
screen -d -m -S "CRT-SCREEN" python3 python/screen2.py
