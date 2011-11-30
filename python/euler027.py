def calc_quad(n, a, b):
    return (n*n) + (a*n) + b

def check_prime(c, priml):
    if c < 2:
        return False
    bp = priml[len(priml) - 1]
    while bp*bp < c:
        bp += 1
        if is_prime(bp, priml):
            priml.append(bp)
    return is_prime(c, priml)
    #not actually adding c to prime list at this time

def is_prime(k, priml):
    for p in priml:
        if k % p == 0:
            return False
        if p * p > k:
            return True
    return True

pl = []

for z in range(2, 100):
    if is_prime(z, pl):
        pl.append(z)
print "go"
max = 0
for a in range(-999, 1000): # starting with 0...
    for b in range(-999, 1000):
        n = 0
        count = -1
        all_prime = True
        while all_prime:
            count += 1
            y = calc_quad(n, a, b)
            all_prime = check_prime(y, pl)
            n += 1
        if count > max:
            max = count
            print "a: " + str(a) + " b: " + str(b) + " count: " + str(count)
