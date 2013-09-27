-module(euler046).

-export([go/0]).

-import(toolbox, []).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Res = iter(9, 109, none),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.

iter(Low, High, PPrimes) ->
    Primes = toolbox:generate_primes(High, PPrimes),
    Odds = lists:seq(Low, High, 2),
    Codds = lists:filter(fun(Odd) -> not toolbox:is_prime(Odd, Primes) end, Odds),
    Negatives = lists:filter(
            fun(Codd) -> disproves_conjecture(Codd, Primes) end,
            Codds
            ),
    case Negatives of
        [] ->
            iter(Low + 100, High + 100, Primes);
        [Head | _] ->
            Head
    end.

disproves_conjecture(Codd, Primes) ->
    Root = erlang:trunc(math:sqrt(Codd)),
    not lists:any(
        fun(Prime) ->
                (Prime < Codd) andalso lists:any(
                    fun(Int) ->
                            Codd == (Prime + (2 * Int * Int)) end,
                    lists:seq(1, Root)
                    )
        end,
        Primes
        ).


