import math


def divs(k):  # number like 28
    divlst = [1]
    j = 2
    count = 0
    low = k + 1
    while j < low and j < k:  # j is 1,2,3,5,7
        if k % j == 0:
            low = k / j
            if j not in divlst:
                divlst.append(j)
            if k / j not in divlst:
                divlst.append(k / j)
        j += 1
    #print divlst
    return int(math.fsum(divlst))
print divs(3)
print divs(4)
print divs(7)
print divs(9)
max = 0
cur_divs = 0
it = 0
print divs(220)
print divs(284)
that = 0
amics = {}
while that < 9999:
    that += 1
    this = divs(that)
    if that != this and (divs(this) == that):
        amics[that] = this
        amics[this] = that
print amics
print math.fsum(amics.keys())
