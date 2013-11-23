#1 3 5 7 9 13 17 21 25 31 37 43 49
#1+2+2+2+2+4 +4 +4 +4 +6 +6 +6 +6

addend = 1
sum = 1
for i in range(1, 501):
    increment = 2 * i  # 0, 2, 4
    for j in range(1, 5):
        addend += increment
        sum += addend
        print addend
print sum
