#!/usr/bin/perl


sub euler3
{
	#wrapper for recursion
	print "enter number to factor: ";
	chomp($a = <>);
	$min = 2;
	if($a < 3)
	{
		print "Stop! You'll ruin everything!\n";
	}
	@Primes = (2);
	@Factors;

	while(&factoring == 1)
	{
		print "generating a prime.\n";
		&genprimes;
	}
	print "\n Factors: @Factors";
		
}


sub factoring
{ # received a number, iterate through list of primes, find a factor
	print "\n".($#Primes+1)." primes currently known; $a is the number to factor\n";
	print "Primes: @Primes\n";
	# check against my list
	for($j = 0; ($j < ($#Primes + 1)); ++$j)	
	{ 
		if(($a % ($Primes[$j])) == 0)
		{
			# found factor 
			print "found factor: $Primes[$j] \n";
			push(@Factors, $Primes[$j]);
			$a /= $Primes[$j];
		}
	}
	if($a == 1)
	{
		return 0;
	} else
	{
		return 1;
	}
}

sub genprimes 
{ # received a number, iterate through list of primes, find a factor
	print "got here";
	# got here, no factor was found in primes, add another number to prime
	$found = 0;
	for($i = $Primes[$#Primes]; (($i <= $a) && ($found == 0)); ++$i) 
	{ # start generating primes
		$prime = 1; # prime until proven otherwise!
		for($k = 0; (($k < ($#Primes + 1)) && ($prime == 1)); ++$k)	
		{ 
			if(($i % $Primes[$k]) == 0)
			{
				$prime = 0; # not prime
			}
		}
		if($prime == 1)
		{ # this number is definitely prime, add to my list of primes and return
			push(@Primes, $i);
			print "found prime!: $i\n";
			return;
		}
	}
	print "\nfailed to generate a new prime less than the number received!\n";
}

&euler3;
