import math

max = 1000

for a in range(1, max):
    for b in range(a, max):
        aa = a*a
        bb = b*b
        cc = aa + bb
        c = math.sqrt(cc)
        if int(c) == c and a+b+c == 1000:
            print a,b,c
            print aa,bb,cc
