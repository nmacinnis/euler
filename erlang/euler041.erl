-module(euler041).

-import(toolbox, []).

-export([go/0]).

go() ->
    %Primes = toolbox:generate_primes(7654322, none),
    Primes = toolbox:generate_primes(30000000, none),
    RPrimes = lists:reverse(Primes),
    scan_for_first_pandigital(RPrimes).

scan_for_first_pandigital(RPrimes) ->
    [Head | Rest] = RPrimes,
    Oom = erlang:trunc(math:log10(Head)),
    Digits = lists:seq(1, Oom + 1),
    case toolbox:is_pandigital(Head, Digits) of
        true ->
            Head;
        false ->
            scan_for_first_pandigital(Rest)
    end.




