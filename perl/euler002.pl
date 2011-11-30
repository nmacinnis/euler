#!/usr/bin/perl

sub euler2
{
	$a = 0;
	$b = 1;
	$d = 0;
	while(($a + $b) < 1000000)
	{
		$c = $b;
		$b += $a;
		$a = $c;
		if(($b % 2) == 0)
		{
			$d += $b;
			print "$d\n";
		}
	}
}

&euler2;
