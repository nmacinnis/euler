t = 2

for i in range(999):
    t *= 2


ts = str(t)
print ts
import math
sum = math.fsum([int(c) for c in ts])
print sum
