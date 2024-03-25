#!/usr/bin/python3

# GPL-3 
# Micha Rathfelder 2024


# read all screen frame from file recorded with
# self.cmd="sigrok-cli --driver=fx2lafw --channels D0=f,D1=h,D2=v --config samplerate=8m  --samples=1700k"

# debian 
# apt install sigrok-firmware-fx2lafw sigrok-cli 
# # optional 
# apt install sigrok pulseview


fname="records/mirkon_wf150_mill_heidenhein_tnc150.txt"
f = open(fname)
lines = f.readlines()
f.close()

frame_on = ""

f = []
p = []
l = []
for line in lines:
    line = line.strip()
    line = line.replace(" ","")
    tmp = []
    if line.startswith("f:"):
        tmp = f
    if line.startswith("h:"):
        tmp = p
    if line.startswith("v:"):
        tmp = l
    line = line[2:]
    line = list(line)
    #for i,v in enumerate(line):
    #    try:line[i]=int(v)
    #    except:pass
    #line = line.replace("1",1)
    #line = line.replace("0",0)
    
    #print(line)
    tmp.extend(line)


def next_frame(f,start=0):
    old = ""
    a=0
    b=0
    #print(start,len(f))
    if start > len(f):
        return 0,0,0

    for i,v in enumerate(f[start:]):
        if v != old:
            if old != "":
                return 1,a+start,i+start
            old=v
            a=i

    return 0,0,0
b=0

import parse2 as parse


######################################################

import pygame
import time


pygame.init()
W=int(1550/2)
H=int(1300/2)
pygame.display.set_mode((W, H))
pygame.display.set_caption("MIKRON BILDSCHIRM")
screen = pygame.display.set_mode((W, H))

pygame.font.init() # you have to call this at the start, 
               # if you want to use this module.
my_font = pygame.font.SysFont('Arial-Bold', 30)


run = True
new_frame = 1
h = 0
fps=0
screen.fill((0,100,100))


print(len(lines))


while run:
    for event in pygame.event.get():
        #print(event.type)
        if event.type == pygame.QUIT:
            run = False

    r,a,b = next_frame(f,start=b)
    if r:
        print("r",r,a,b,b-a)
        if 1: #b-a > 4726+100:
            f3 = f[b:]
            p3 = p[b:]
            l3 = l[b:]
            lines = parse.get_line(f3,p3,l3)

    if not lines:
        print("nix")
        time.sleep(1)
        continue
    screen.fill((0,100,100))

    h=0
    for h2,line in enumerate(lines):
        v=0
        for v2,pix in enumerate(line):
            if v2 % 2 ==0:
                continue
            v+=1
            color = (0,0,0)
            if pix != " ":
                color = (255,255,255)
            pygame.draw.line(screen, color, [v+10,h+10], [v+10,h+10])#, width=1)
        h += 2

    fps+=1
    bg = (0,255,0)
    if fps % 2 == 0:
        bg = (0,255,255)
    pygame.draw.rect(screen, bg, (5,H-30, 90,25))#, width=1)
    text_surface = my_font.render('FPS:'+str(fps), False, (0, 0, 0))
    screen.blit(text_surface, (10,H-30))

    pygame.display.flip()
    # time.sleep(0.3)


