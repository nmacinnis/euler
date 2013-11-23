def sqn(i):
    if i % 2 != 1:
        i /= 2
    else:
        i = (i * 3) + 1
    return i
max = 0
maxk = 0
for j in range(999999, 2, -1):
    k = j
    count = 0
    while j != 1:
        j = sqn(j)
        count += 1
        if count > max:
            max = count
            maxk = k
    print "k: " + str(k) + " count: " + str(count) + " max: " + str(
        max) + " maxk: " + str(maxk)
