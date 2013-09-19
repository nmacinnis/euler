-module(euler043).

-export([go/0]).

go() ->
    Primes = toolbox:generate_primes(17, none),
    Digits = lists:seq(0, 9),
    Pandigitals = toolbox:permutate_digits(Digits),
    io:format("count: ~p~n", [erlang:length(Pandigitals)]),
    lists:foldl(
        fun(Pandigits, Acc) ->
                case (erlang:length(Pandigits) == 10) and (has_interesting_property(Pandigits, Primes)) of
                    true ->
                        Acc + toolbox:digits_to_integer(Pandigits);
                    false ->
                        Acc
                end
        end,
        0,
        %(true) and (has_interesting_property(Pandigits, Primes)) end,
        Pandigitals
        )
    .

has_interesting_property(NDigits, Primes) ->
    lists:all(
        fun(I) ->
                SubN = toolbox:digits_to_integer(lists:sublist(NDigits, I + 1, 3)),
                Prime = lists:nth(I, Primes),
                %io:format("checking ~p rem ~p~n", [SubN, Prime]),
                SubN rem Prime == 0 end,
        lists:seq(1, 7)
        ).



