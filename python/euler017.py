dc = {
    0: 0,
    1: 3, 2: 3, 3: 5, 4: 4, 5: 4,
    6: 3, 7: 5, 8: 5, 9: 4, 10: 3,
    11: 6, 12: 6, 13: 8, 14: 8, 15: 7,
    16: 7, 17: 9, 18: 8, 19: 8, 20: 6,
    30: 6, 40: 5, 50: 5, 60: 5,
    70: 7, 80: 6, 90: 6, 100: 7,  # hundred
    1000: 8  # thousand
}
ichr = 0
for i in range(1, 1001):
    print "i: " + str(i)
    if i == 1000:
        ichr += dc[1000]
        i = 0
    if i >= 100:
        nhund = i / 100
        i = i % 100
        if i != 0:
            ichr += 3  # and
        ichr += dc[nhund] + dc[100]
    if i > 19:
        tens = (i / 10) * 10
        ichr += dc[tens]
        i -= tens
    ichr += dc[i]
    print "ichar: " + str(ichr)
