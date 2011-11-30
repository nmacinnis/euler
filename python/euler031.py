
def get_vals(coins, key_index, cur_val, max):
    if cur_val == max:
        #print "returned 1"
        return 1
    coinval = coins[key_index]
    #print coinval, cur_val
    maxcoins = max/coinval # 2P:1, 1P:2, 2p:100, 1p:200
    if coinval == 1:
        #print "returned 1"
        #print "z"
        return 1
    count = 0
    for i in range(maxcoins + 1): # this will give at least 0 and 1 for 2P
            cur_val += coinval # i believe the toruble is here
            #print cur_val
            if cur_val <= max:
                #print coinval, cur_val
                count += get_vals(coins, key_index + 1, cur_val, max)
    return count


coins = [200,100,50,20,10,5,2,1]
coins2 = [5,2,1]
#print get_vals(coins, 0, 0, 4)
print get_vals(coins2, 0, 0, 0)#1
print get_vals(coins2, 0, 0, 1)#1
print get_vals(coins2, 0, 0, 2)#2
print get_vals(coins2, 0, 0, 3)#2
print get_vals(coins2, 0, 0, 4)#3
