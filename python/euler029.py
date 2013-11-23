terms = {}
import math
for a in range(2, 101):
    for b in range(2, 101):
        terms[int(math.pow(a, b))] = 1

print len(terms.keys())
