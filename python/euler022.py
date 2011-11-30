names = open("names.txt").read()

names = [n.strip('"') for n in names.split(",")]
names.sort()


letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

ltd = {}
for letter in letters:
    ltd[letter] = letters.find(letter) + 1
print ltd

sum = 0
count = 0
for name in names:
    count += 1
    namesum = 0
    print name
    for letter in name:
        namesum += ltd[letter]
    sum += namesum * count

print sum
