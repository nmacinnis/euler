-module(toolbox).

-export([reduce/2, gcd/2, lcm/2]).

reduce(Num, Den) ->
    Factor = gcd(Num, Den),
    {Num div Factor, Den div Factor}.

% http://rosettacode.org/wiki/Least_common_multiple#Erlang
gcd(A, 0) ->
    A;
gcd(A, B) ->
    gcd(B, A rem B).

lcm(A, B) ->
    abs(A * B div gcd(A, B)).
