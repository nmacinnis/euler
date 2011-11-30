#!/usr/bin/perl


sub euler1
{
	$c = 0;
	for($i = 0; $i < 1000; ++$i)
	{
		if((($i % 3) == 0 ) || (($i % 5) == 0))
		{
			print "$i \n";
			$c += $i;
			print "$i; $c \n";
		}
	}
}

&euler1;
