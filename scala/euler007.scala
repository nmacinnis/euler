


import Console.println

var primes : List[Int] = List(2)

val max = 100
//var i: Int = 2
for (val i <- 3 to max) {
	if (isPrime(i))
		primes = List(i) ::: primes
}

def isPrime(k: Int): Boolean = {
	var prime = true
	for (val j <- primes.indices ) {
		if (k % primes(j) == 0) prime = false
	}
	return prime
}



primes = primes.reverse


println(primes(5))
