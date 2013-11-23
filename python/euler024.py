

def permutate(seq):
    """permutate a sequence and return a list of the permutations"""
    global count
    if not seq:
        return [seq]  # is an empty sequence
    else:
        temp = []
        for k in range(len(seq)):
            part = seq[:k] + seq[k + 1:]
            for m in permutate(part):
                temp.append(seq[k:k + 1] + m)
        return temp

print permutate([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])[999999]
