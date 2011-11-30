grid = []
for i in range(21):
    grid.append([])
    for j in range(21):
        grid[i].append(0)

print grid

grid[20][20] = 1

for i in range(20, -1, -1):
    for j in range(20, -1, -1):
        if i+1 < 21:
            grid[i][j] += grid[i+1][j]
        if j+1 < 21:
            grid[i][j] += grid[i][j+1]
    
print grid
