-module(euler_001).
-export([go/0]).

go() ->
	fizzbuzz(lists:seq(1,999)).

fizzbuzz(List) -> 
	lists:sum(
		[B || 
			B <- List,
			(B rem 3 =:= 0) or
			(B rem 5 =:= 0)
		]
	).
	


