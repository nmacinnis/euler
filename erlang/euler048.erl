-module(euler048).

-export([go/0]).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Res = lists:foldl(
            fun(N, Acc) -> (Acc + bigpow(N)) rem 10000000000 end,
            0,
            lists:seq(1,1000)
            ),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.

bigpow(N) ->
    lists:foldl(
        fun(_, Acc) -> (N * Acc) rem 10000000000 end,
        1,
        lists:seq(1, N)
        ).
