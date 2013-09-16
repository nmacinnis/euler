def prime_generator(limit=None):
    retrieved = 0
    found = 1
    max_found = 2
    extent_marked = 3
    primes = [2]
    while True:
        if extent_marked == limit and retrieved == found:
            raise Exception("no more!")
        yield primes[retrieved]
        retrieved += 1
        if retrieved == found:
            # we've got more work to do!
            new_extent = min(max_found * max_found, limit) if limit else max_found * max_found
            space = range(extent_marked, new_extent)
            print "marking %s to %s" % (extent_marked, new_extent)
            extent_marked = new_extent
            space = remove_composites(space, primes)
            primes.extend(space)
            print "known primes after: ", primes
            found = len(primes)
            max_found = primes[-1]

def remove_composites(space, primes):
    print "known primes before: ", primes
    if not space:
        return
    p = 0
    #while p <= len(primes) and pow(primes[p], 2) < space[-1]:
    while pow(primes[p], 2) < space[-1]:
        prime = primes[p]
        #print space
        print "marking multiples of %s" % prime
        space = [i for i in space if i % prime != 0]
        p += 1
    return space

def get_n_primes(n, limit=None):
    pg = prime_generator(limit=limit)
    return [pg.next() for i in xrange(n)]


def get_100_primes():
    pg = prime_generator(limit=100000)
    return [pg.next() for i in xrange(25)]

if __name__ == "__main__":
    #print get_100_primes()
    print get_n_primes(500, limit=100000)

