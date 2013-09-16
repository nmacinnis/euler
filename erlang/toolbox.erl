-module(toolbox).

-export([reduce/2, gcd/2, lcm/2]).
-export([fact/1]).
-export([integer_to_digits/1, reverse_str/1, num_to_bin/1, sum_digits/1]).
-export([is_palindrome/1, is_num_palindrome/1]).
-export([generate_primes/2]).
-export([lr_truncate/1, rl_truncate/1]).


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

num_to_bin(Num) ->
    integer_to_list(Num, 2).

is_num_palindrome(Num) ->
    Numstr = erlang:integer_to_list(Num),
    is_palindrome(Numstr).

reverse_str(Str) ->
    lists:reverse(Str).

is_palindrome(Str) ->
    Str == lists:reverse(Str).

generate_primes(Limit, none) ->
    generate_primes(Limit, ordsets:from_list([2]));
generate_primes(Limit, []) ->
    generate_primes(Limit, [2]);
generate_primes(Limit, Primes) ->
    [Tail | _] = lists:reverse(Primes),
    Min = Tail,
    Max = erlang:min(Limit, Tail * Tail),
    io:format("collecting primes from ~p to ~p ~n", [Min, Max]),
    Space = lists:seq(Min, Max),
    NewPrimes = ordsets:filter(fun(N) -> is_prime(N, Primes) end, Space),
    Union = ordsets:union(Primes, NewPrimes),
    case Max of
        Limit ->
            Union;
        Max ->
            generate_primes(Limit, Union)
    end.

is_prime(_N, []) ->
    true;
is_prime(N, [Head | _]) when (Head * Head) > N ->
    true;
is_prime(N, Primes) ->
    [Head | Rest] = Primes,
    (N rem Head =/= 0) and is_prime(N, Rest).

lr_truncate(N) ->
    [_ | Rest] = erlang:integer_to_list(N),
    case Rest of
        [] ->
            [N];
        Rest ->
            {NRest, []} = string:to_integer(Rest),
            [N] ++ lr_truncate(NRest)
    end.

rl_truncate(N) ->
    Digits = erlang:integer_to_list(N),
    Body = lists:sublist(Digits, erlang:length(Digits) - 1),
    case Body of
        [] ->
            [N];
        Body ->
            {NBody, []} = string:to_integer(Body),
            [N] ++ rl_truncate(NBody)
    end.
