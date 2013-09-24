-module(euler243).

-import(toolbox, []).

-export([go/0]).
-export([totient/2, resilience/1]).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Target = 15499 / 94744,
    %Target = 4/10,
    {Primes, Product, LastPrime} = find_irresilient_primorial_divisor(1, Target, [2]),
    D = find_smallest_irresilient_divisor(Primes -- [LastPrime], Target, Product, LastPrime, 2),

    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [D, (End - Start)]),
    D.

find_irresilient_primorial_divisor(Index, Target, Primes) ->
    NPrimes = case Index > erlang:length(Primes) of
        true ->
            toolbox:generate_primes(lists:nth((Index - 1), Primes) * 10, Primes);
        false ->
            Primes
    end,
    D = lists:nth(Index, NPrimes),
    Factors = lists:sublist(NPrimes, 1, Index),
    {Product, Totient, Resilience} = resilience(Factors),
    io:format("primorial resilience @ ~p, d = ~p: ~p/~p = ~p", [D, Product, Totient, (Product - 1), Resilience]),
    case Resilience < Target of
        true ->
            io:format(" (low enough)~n", []),
            {Factors, Product, D};
        false ->
            io:format(" (too high)~n", []),
            find_irresilient_primorial_divisor(Index + 1, Target, NPrimes)
    end.


find_smallest_irresilient_divisor(_Primes, _Limit, TargetDiv, DroppedPrime, DroppedPrime) ->
    TargetDiv;
find_smallest_irresilient_divisor(Primes, Limit, TargetDiv, DroppedPrime, I) ->
    Combo = [ I | Primes ],
    {Product, Totient, Resilience} = resilience(Combo),
    io:format("resilience @ ~p, d = ~p: ~p/~p = ~p", [I, Product, Totient, (Product - 1), Resilience]),
    case (Resilience < Limit) of
        true ->
            case (Product < TargetDiv) of
                true ->
                    io:format(" (new best divisor)~n", []),
                    Product;
                false ->
                    io:format(" (divisor too high)~n", []),
                    TargetDiv
            end;
        false ->
            io:format(" (too high)~n", []),
            find_smallest_irresilient_divisor(Primes, Limit, TargetDiv, DroppedPrime, I + 1)
    end.

resilience(Factors) ->
    Pr = toolbox:product(Factors),
    PrFactors = sets:to_list(sets:from_list(Factors)),
    Totient = totient(Pr, PrFactors),
    {Pr, Totient, (Totient / (Pr - 1))}.


totient(Pr, PrimeFactors) ->
    erlang:trunc(
        lists:foldl(
            fun(Factor, Product) -> Product * (1 - (1 / Factor)) end,
            Pr,
            PrimeFactors
            )
        ).
