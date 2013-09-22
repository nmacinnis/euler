from io import open
from toolbox import nmin


if __name__ == "__main__":
    file = open("matrix.txt", "r")
    matrix = [
        [int(token) for token in line.split(",")]
        for line in file.readlines()
    ]
    for i in range(len(matrix)):
        for j in range(len(matrix[0])):
            cell = matrix[i][j]
            cell_above = 0
            cell_left = None
            if i != 0:
                cell_above = matrix[i - 1][j]
            if j!= 0:
                cell_left = matrix[i][j - 1]
            min_neighbor = nmin(cell_above, cell_left)
            matrix[i][j] = cell + min_neighbor

    print matrix[-1][-1]



