import math

def divs(k): # number like 28
    divlst = [1]
    j = 2
    count = 0
    low = k + 1
    while j < low and j < k: # j is 1,2,3,5,7
        if k % j == 0:
            low = k / j
            if j not in divlst:
                divlst.append(j)
            if k/j not in divlst:
                divlst.append(k/j)
        j += 1
    #print divlst
    return int(math.fsum(divlst))


abun = []
for i in range(1, 28124):
    if i < divs(i):
        abun.append(i)
absum = {}
for i in range(len(abun)):
    print "i: " + str(i) 
    a = abun[i]
    for j in range(i, len(abun)):
        b = abun[j]
        absum[a+b] = 1
sum = 0
for s in range(28124):
    if s not in absum.keys():
        sum += s
print sum
