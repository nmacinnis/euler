def is_prime(k, priml):
    for p in priml:
        if k % p == 0:
            return False
        if p * p > k:
            return True
    return True

npl = range(2, 200000)
pl = []

for z in npl:
    if is_prime(z, pl):
        pl.append(z)

print pl
print pl[10000]
