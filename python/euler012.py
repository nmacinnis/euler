

def divs(k):  # number like 28
    j = 1
    count = 0
    low = k + 1
    while j < low:  # j is 1,2,3,5,7
        if k % j == 0:
            low = k / j
            count += 2
        j += 1
    return count


max = 0
cur_divs = 0
it = 0
that = 0

while cur_divs < 500:
    that += 1
    it += that
    cur_divs = divs(it)
    #print "divs: " + str(cur_divs) + " it: " + str(it)
    if cur_divs > max:
        max = cur_divs
        print "max: " + str(cur_divs) + " it: " + str(it)
    if cur_divs > 500:
        print it
