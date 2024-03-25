#!/usr/bin/python3
import os
import time

fname="frame.txt"


def parse_file(lines):

    f = []
    p = []
    l = []
    fps_count = 0
    fps_flip = 0
    fps_old = ""

    for i,line in enumerate(lines):
        tmp = []
        k = "x"
        if line.startswith("f:"):
            line = line[2:]
            tmp = f
            k = "f"
            #print([line])

            if "1" in line:
                if fps_old == 0 :
                    fps_flip = 1
                    fps_old=1
            else:
                if fps_old == 1:
                    fps_old=0
    
            if fps_flip:
                fps_count += 1
                fps_flip = 0

        elif line.startswith("h:"):
            line = line[2:]
            tmp = p
            k = "p"
        elif line.startswith("v:"):
            line = line[2:]
            tmp = l
            k = "l"

        line = line.strip()
        line = line.split()
        line = "".join(line)
        b=list(line)
        tmp.extend(b)
        #print("line",k,len(tmp),line)
    print("fps:file:",fps_count)    
    return f,p,l

def read_file(fname):
    s1 = time.time()
    f = open(fname)
    lines = f.readlines()
    f.close()
    s2 = time.time()
    #print("read_file",s2-s1)
    return parse_file(lines)



class Frame():
    def __init__(self):
        self.init = 0
        self.frame_on = 0
        self.frame_end = 0

    def start(self,v):
        if self.frame_on:
            return True

        if self.init == 0 and v == "0":
            self.init=1
        elif self.init == 1 and v == "1":
            self.init=2
        elif self.init == 2 and v == "0":
            self.frame_on = 1
            print("frame ON")
            self.init=3
            return True

        return False

    def end(self,v):
        if self.frame_end:
            return True

        if self.frame_on and v == "1":
            self.frame_end = 1
            print("frame END")
            return True
        return False
    
    def reset(self):
        self.init = 0
        self.frame_on = 0
        self.frame_end = 0

frame = Frame()
def get_line(f,p,l):
    #return [[" "*200],["1"*200]]
    #print("get_line")
    ok=0
    line=[]
    lines = []
    idelta = 0
    idelta_c=0
    frame.reset()
    i_old=0

    frame_count_old = ""
    frame_count = 0
    #for i,v in enumerate(f):
    #    if v != frame_count_old:
    #        frame_count_old = v
    #        if v == "0":
    #            frame_count += 1

    #for i,v in enumerate(l):
    #i = -1
    #_max = len(l)
    #while 1:
    #    i+=1
    #    if i > _max:
    #        break
    #    v = l[i]
    for i,v in enumerate(l):
        try:
            if not frame.start(f[i]):  
                continue

            if frame.end(f[i]):
                print(len(line),len(lines))
                return lines
             

            if v == "1" and ok == 0: # line is on
                ok=1

            if ok==1 and v == "1": # waite linesignale end
                continue


            if ok:
                #print([i,v],end="")
                vv = p[i]
                if vv == "0":
                    vv=" "
                else:
                    vv="#"
                #print(vv,end="")
                line.append(vv)
                ok+=1
                if v=="1": # reset line signal !
                    ok=0
                    idelta = i- i_old
                    c=0
                    if idelta > 1576:
                        idelta_c+=1
                        c = int(idelta / 1576) #calc missing lines
                        if c > 144: #max space 144 lines
                            c = 144
                        if idelta_c > 1: # fill missing lines
                            for ii in range(c):
                                lines.append([])

                    #print("---",i,idelta,c)
                    #print("frame_count",frame_count )
                    #print(len(line),len(lines))
                    i_old=i
                    lines.append(line)
                    line = []
        except:pass
    print(frame_count )
    return lines

def scanline(f,p,l):
    pass

if __name__ == "__main__":
    fname="frame.txt"
    fname="frame_8m.txt"
    f,p,l = read_file(fname)
    #print(p)
    lines = get_line(f,p,l)

