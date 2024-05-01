import time
import random
import os

def build_frame(f,p,l):
    frame = []
    frame_line = []
    old_l = ""
    #p = p.replace("0","#")
    #p = p.replace("1"," ")
    for i,v in enumerate(p):
        if l[i] != old_l:
            old_l = l[i]
            
            if l[i] == "0":
                #print("#")
                a = "".join(frame_line)
                frame.append(a)
                frame_line = []
        #print(v,end="")
        frame_line.append(v)
    return frame

class Counter():
    def __init__(self):
        self.data = {}
        self.data["X"] = {"count":0,"old":""}

    def get(self,k):
        if k in self.data:
            return self.data[k]["count"]
        return 0

    def check(self,k,v,count_value=""):
        k = str(k)
        if k not in self.data:
            self.data[k] = {"count":0,"old":""}

        if v != self.data[k]["old"]:
            self.data[k]["old"] = v
            if count_value:
                if v == count_value:
                    self.data[k]["count"] += 1
                    return 1
            else:
                self.data[k]["count"] += 1
                return 1
def merge(f,p,l):
    f = "".join(f)
    p = "".join(p)
    l = "".join(l)
    return f,p,l
def gen_rand_frame():
    _line = []
    for i in range(100):
        a = random.randint(0,1)
        _line.append(str(a)*10)
    
    frame = ["".join(_line)]*200
    return frame

def parse_sigrok_frame(lines,max_frame=0):
    f,p,l=[],[],[]
    
    frames = [["0000000000000001111111111111111111110000000111111110000000111111111"*2]*50] # test frame
    _line = []

    #frames.append(gen_rand_frame())

    frame_lines = []
    counter = Counter()
    # if counter.check("frame",i,count_value="0"):
    # if counter.get("frame") >= 1:

    end = 0
    dbg=0

    for line in lines:
        line = line.replace(" ","")
        line = line.strip()
        if line[:2] == "f:":
            if dbg:print()
            a=line[2:]
            if dbg:print(a,end=":f ")
            f.append(a)

            for i in a: #line[:2]:
                if counter.check("frame",i,count_value="0"):
                    if counter.get("frame") > 0:
                        #frames.append(frame_lines)
                        #frame_lines = []

                        f,p,l = merge(f,p,l)
                        nframe = build_frame(f,p,l)
                        
                        frames.append(nframe)
                        f,p,l=[],[],[] # clear

                    if max_frame > 0:
                        if max_frame < counter.get("frame"):
                            end = 1

        elif line[:2] == "h:":
            a=line[2:]
            if dbg:print(a,end=":h") 
            p.append(a)
        elif line[:2] == "v:":
            a=line[2:]
            # print(a,end=":v ")
            if dbg:print(a,end=":v{:10} ".format(line_count))
            l.append(a)

        if end:
            break
    print()
    print("max:{} count:{}".format(max_frame,counter.get("frame")))
    print("frames",len(frames))
    return frames,counter #.get("frame")


def parse_sigrok_frame_csv(lines,max_frame=0):
    f,p,l=[],[],[]
    _line = []
    frames = [["0000000000000001111111111111111111110000000111111110000000111111111"*2]*50] # test frame

    #frames.append(gen_rand_frame())

    frame  = []
    frame_line = []

    counter = Counter()
    # if counter.check("frame",i,count_value="0"):
    # if counter.get("frame") >= 1:

    end = 0
    dbg=0
    
    for line in lines:

        line = line.strip()
        line = line.split(",")
        
        #print(line)
        if len(line) == 3:
            f = line[0]
            l = line[1]
            p = line[2]
            
            if counter.check("frame",f,count_value="0"):
                frames.append(frame)
                frame=[]
                print("\n"*4)

            if max_frame > 0:
                if max_frame < counter.get("frame"):
                    break
            
            if counter.get("frame") >= 1:
                frame_line.append(p)
                #print(p,end="")
            
            if counter.check("line",l,count_value="0"):
                if counter.get("line") >= 1:
                    a="".join(frame_line)
                    print(a)
                    frame.append(a)
                    frame_line=[]

    #frames.append(frame)
    return frames,counter

class File():
    def __init__(self):
        self.fname="../records/mirkon_wf150_mill_heidenhein_tnc150.txt"
        #self.fname="/home/user/projects/20240430-capture-csv/caputreMenue.log"
        self.fname="/home/user/projects/20240430-capture-csv/startup3.log"
        self.fname="/home/user/projects/20240430-capture-csv/startup1.log"
        self.fname="/home/user/projects/20240430-capture-csv/startup.log"
        #self.fname="/home/user/projects/20240430-capture-csv/caputreMenue.log" 
        #self.fname="/home/user/projects/20240430-capture-csv/caputre0y.log" 
        #self.fname="/home/user/projects/20240430-capture-csv/" 
        #self.fname="/home/user/projects/20240430-capture-csv/caputreStartZ.csv"
        #self.mode = "csv"

        self.start = 1
        self.open()
        self.last_frame_count = -1
        self.counter = Counter()
        self.frame = []
        self.frame_end = 0

    def open(self):
        f = open(self.fname)
        self.lines = f.readlines()
        f.close()
    def junk(self):
        s1 = time.time()
        lines = self.lines
        if self.frame_end == 0:
            frames,self.counter = parse_sigrok_frame(lines,max_frame=self.start)
            #frames,self.counter = parse_sigrok_frame_csv(lines,max_frame=self.start)
            self.frame = frames[-1]
        if self.counter.get("frame") > self.last_frame_count:
            self.last_frame_count = self.counter.get("frame")
        else:
            self.frame_end = 1

        self.start += 1

        s2 = time.time()
        s2 = time.time()
        s3 = time.time()
        print("time:",round(s2-s1,2),round(s2-s3,2))
        print("time:",round(s1-s3,2))
        return self.frame

class Stream():
    def __init__(self):
        # sample rate 4m 6m 8m 12m 24m
        self.cmd="sigrok-cli --driver=fx2lafw --channels D0=f,D1=h,D2=v --config samplerate=24m  --triggers f=r  --samples=1700k"
        #self.cmd="sigrok-cli --driver=fx2lafw --channels D0=f,D1=h,D2=v --config samplerate=8m  --samples=1700k"
        self.start = 0
    def junk(self):
        print(self.cmd)
        r=os.popen(self.cmd)
        lines = r.readlines()

        if 1: #if self.frame_end == 0:
            frames,self.counter = parse_sigrok_frame(lines,max_frame=self.start)
            #frames,self.counter = parse_sigrok_frame_csv(lines,max_frame=self.start)
            self.frame = frames[-1]

        #if self.counter.get("frame") > self.last_frame_count:
        #    self.last_frame_count = self.counter.get("frame")

        #self.start += 1
        return frames[-1]


reader = File()
reader = Stream()

##lines=reader.junk()

import pygame
import time

pygame.init()

W=820
H=650

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

    frame = reader.junk()
    if not frame:
        continue

    lines = frame
    if not lines:
        continue


    screen.fill((0,100,100))

    h=0
    for h2,line in enumerate(lines):
        #print(line,"-")
        if not line:
            continue
        line = line.replace("0"," ")
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
    time.sleep(0.3)
    time.sleep(0.3)
