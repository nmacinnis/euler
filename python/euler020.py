prod = 1
for i in range(1, 100):
    #print i
    prod *= i
    #print prod
    #if prod/10 * 10 == prod:
    #    prod /= 10
    #print prod

#print prod
sumstr = str(prod)
sum = 0
for c in sumstr:
    j = int(c)
    sum += j
print sum
