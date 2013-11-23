#!/usr/bin/env python
# less talk more rock
coins = [1, 2, 5, 10, 20, 50, 100, 200][::-1]
#print coins
total = 200

practice_coins = [5, 2, 1]


def ways(coins, number):
    '''Return how many ways we can make the coins add up to number.'''
    if coins[0] == 1:
        return 1
    current_ways = 0

    #number of ways the coin[0] can be used
    max = number / coins[0]

    #for each way coin[0] can be used, determine how many ways the rest of
    #the coins can be used
    for ii in range(max + 1):  # [0,1,2]
        next_number = number - (ii * coins[0])
        if next_number == 0:
            current_ways = current_ways + 1
        else:
            current_ways = current_ways + ways(coins[1:], next_number)
    return current_ways


print ways(coins, 200)


#  2 1
#2 1 0
#1 0 2

#   5 2 1
#0  1 0 0
#1  0 2 1
#2  0 1 3
#3  0 0 5


#   10 5 2 1
#0   1 0 0 0
#1   0 2 0 0
#2   0 1 2 1
#3   0 1 1 3
#4   0 1 0 5
#5   0 0 5 0
#6   0 0 4 2
#7   0 0 3 4
#8       2 6
#9       1 8
#10      0 10


# how many ways can you make 5 with 2s and 1s
# 3 obviously   221, 2111, 11111
# how many ways can you make 5 with 5,2,1
# 4 because you add one way
# how many ways can you make 10 with 10,5,2,1
# 6 + 3 + 1
