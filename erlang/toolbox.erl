-module(toolbox).

-export([reduce/2, gcd/2, lcm/2, fact/1, sum_digits/1, integer_to_digits/1]).

integer_to_digits(N) ->
    lists:map(
        fun(DigitStr) ->
                {Digit, []} = string:to_integer([DigitStr]),
                Digit
        end,
        erlang:integer_to_list(N)).

sum_digits(N) ->
    lists:sum(integer_to_digits(N)).

fact(N) when N =< 1 ->
    1;
fact(N) ->
    N * fact(N - 1).

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
