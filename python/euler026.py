def divide(top, bottom, qr={}, curses=0):
    if top == 0:
        return (0, 0)
    quotient = int(top / bottom)
    remainder = int(top % bottom)
    if remainder == 0:
        print "ok"
        return (quotient, 0)
    if (quotient, remainder) in qr:
        # cycle!
        b = curses - qr[(quotient, remainder)]
        return (0, b)
    else:
        qr[(quotient, remainder)] = curses
    tup = divide(remainder * 10, bottom, qr=qr, curses=curses + 1)
    retval = tup[0]
    cycle_length = tup[1]
    a = float(quotient + (retval * .1))
    return (a, cycle_length)

max = 0
maxi = 0
for i in range(1, 1000):
    t = divide(1, i, {}, 0)
    print str(i) + " :: " + str(t[0]) + " : " + str(t[1])
    if t[1] > max:
        max = t[1]
        maxi = i
print maxi
