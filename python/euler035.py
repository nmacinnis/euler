from toolbox import prime_generator, rotate_digits

noncircular_primes = set()
circular_primes = set()

def find_circular_primes(limit=100):
    primer = prime_generator(limit=limit)
    primes = []
    try:
        while True:
            primes.append(primer.next())
    except:
        pass
    primes = filter_for_circular_primes(primes)
    print primes
    return len(primes)


def filter_for_circular_primes(primes):
    primes = [prime for prime in primes if is_prime_circular(prime, primes)]
    return primes

def is_prime_circular(prime, primes):
    global noncircular_primes, circular_primes
    if prime in circular_primes:
        return True
    if prime in noncircular_primes:
        return False
    rotations = rotate_digits(str(prime))
    for rotation in rotations:
        if not int(rotation) in primes:
            print prime, " is not circular ", len(circular_primes), len(noncircular_primes)
            for rotation in rotations:
                noncircular_primes.add(int(rotation))
            #noncircular_primes = noncircular_primes.union([int(rotation) for rotation in rotations])
            return False
    print prime, " is circular"
    circular_primes = circular_primes.union([int(rotation) for rotation in rotations])
    for rotation in rotations:
        circular_primes.add(int(rotation))
    return True



if __name__ == "__main__":
    print find_circular_primes(limit=1000000)
    #print find_circular_primes(limit=1000000)
