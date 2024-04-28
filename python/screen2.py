import time

import os
import parse2 as parse 

class File():
    def __init__(self):
        self.fname="records/mirkon_wf150_mill_heidenhein_tnc150.txt"
        #self.fname="records/out.txt" #mirkon_wf150_mill_heidenhein_tnc150.txt"
        #self.fname="records/out3.txt" #mirkon_wf150_mill_heidenhein_tnc150.txt"
    def junk(self):
        s1 = time.time()
        f,p,l = parse.read_file(self.fname)
        s2 = time.time()
        lines = parse.get_line(f,p,l)
        s3 = time.time()
        print("time:",round(s1-s2,2),round(s2-s3,2))
        print("time:",round(s1-s3,2))
        return lines

class Stream():
    def __init__(self):
        # sample rate 4m 6m 8m 12m 24m
        self.cmd="sigrok-cli --driver=fx2lafw --channels D0=f,D1=h,D2=v --config samplerate=24m  --samples=1700k"
        self.cmd="sigrok-cli --driver=fx2lafw --channels D0=f,D1=h,D2=v --config samplerate=8m  --samples=1700k"
    def junk(self):
        print(self.cmd)
        r=os.popen(self.cmd)
        lines = r.readlines()
        f,p,l = parse.parse_file(lines)
        lines = parse.get_line(f,p,l)
        return lines

class read_big_file():
    def __init__(self):
        self.fname="frame_8m.txt"
        self.fname="../langes-sample-mikron2.txt" #frame_8m.txt"
        self.f = None
        self.l = 0
        self.lread = 55000
        self.end = 0
    def open(self):
        if not self.f:
            self.f = open(self.fname)
    def junk(self):
        self.open()
        lines=[]
        if self.end == 0:
            for i in range(self.lread):
                line = self.f.readline()
                if not line:
                    self.end = 1
                lines.append(line)

            for xx in range(30): # fastforward
                for i in range(self.lread):
                    self.f.readline()
        else:
            time.sleep(1)
        self.l += 1 #self.lread
        print("lines count",len(lines),self.l)
        #f,p,l = parse.read_file(fname)
        f,p,l = parse.parse_file(lines)
        out = parse.get_line(f,p,l)
        return out

reader = File()

#reader = read_big_file()
#reader.fname="frame_8m.txt"

reader = Stream()
#reader = read_big_file()

lines=reader.junk()

import pygame
import time

pygame.init()

W=700
H=600

pygame.display.set_mode((W, H))
pygame.display.set_caption("VIRTUAL CRT SCREEN OUTPUT")
screen = pygame.display.set_mode((W, H))

pygame.font.init() # you have to call this at the start, 
                   # if you want to use this module.
my_font = pygame.font.SysFont('Arial-Bold', 30)


run = True
new_frame = 1
h = 0
fps=0
screen.fill((0,100,100))
while run:
    for event in pygame.event.get():
        print(event.type)
        if event.type == pygame.QUIT:
            run = False
    lines = reader.junk()
    if not lines:
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
            #pygame.draw.rect(screen, color, [v,h, 1,1])#, width=1)
        h += 2

    fps+=1
    bg = (0,255,0)
    if fps % 2 == 0:
        bg = (0,255,255)
    pygame.draw.rect(screen, bg, (5,H-30, 90,25))#, width=1)
    text_surface = my_font.render('FPS:'+str(fps), False, (0, 0, 0))
    screen.blit(text_surface, (10,H-30))

    pygame.display.flip()
    time.sleep(0.3)
