i = 0
j = 1
temp = 0
count = 0
while len(str(j)) < 1000:
    count += 1
    temp = j
    j += i
    i = temp

print count
