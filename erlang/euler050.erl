-module(euler050).

-export([go/0]).

go() ->
    Primes = toolbox:generate_primes(1000000, none),
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Res = iter(1, 1, 0, lists:last(Primes), Primes, {0, 0}),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.

iter(Start, Len, _Sum, _Last, Primes, {Max, Most}) when (Start + Len) > erlang:length(Primes) ->
    {Max, Most};
iter(_Start, Len, Sum, Last, _Primes, {Max, Most}) when (Sum > Last) and (Len == (Most + 1))->
    {Max, Most};
iter(Start, _Len, Sum, Last, Primes, {Max, Most}) when (Sum > Last) ->
    NewSum = lists:sum(lists:sublist(Primes, Start + 1, Most + 1)),
    iter(Start + 1, Most + 1, NewSum, Last, Primes, {Max, Most});
iter(Start, Len, Sum, Last, Primes, {Max, Most}) ->
    case lists:member(Sum, Primes) of
        true ->
            io:format("new high found, ~p sum of ~p consecutive primes~n", [Sum, Len]),
            NewSum = lists:sum(lists:sublist(Primes, Start, Len + 1)),
            iter(Start, Len + 1, NewSum, Last, Primes, {Sum, Len});
        false ->
            NewSum = lists:sum(lists:sublist(Primes, Start, Len + 1)),
            iter(Start, Len + 1, NewSum, Last, Primes, {Max, Most})
    end.


