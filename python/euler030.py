import math


def d_sum(k):
    nums = [math.pow(int(d), 5) for d in str(k)]
    return int(sum(nums))

for i in range(1000000):
    if i == d_sum(i):
        print i
