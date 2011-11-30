s_squares = 0
s_sums = 0

for i in range(101):
	s_sums += i
	s_squares += i*i

s_sums *= s_sums
print s_sums - s_squares
