def is_prime(k, priml):
    for p in priml:
        if k % p == 0:
            return False
        if p * p > k:
            return True
    return True

npl = range(2, 2000000)
pl = []

for z in npl:
    if is_prime(z, pl):
        pl.append(z)

import math
print math.fsum(pl)
