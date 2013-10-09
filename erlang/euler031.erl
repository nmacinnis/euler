-module(euler031).

-export([go/0]).

-import(toolbox, []).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Coins = [200, 100, 50, 20, 10, 5, 2, 1],
    Res = ways(Coins, 200),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.

ways([1], _Total) ->
    1;
ways(Coins, Total) ->
    % how many ways can coins add up to total?
    [Coin | Rest] = Coins,
    Ways = Total div Coin,
    lists:foldl(
        fun(Num, Sum) -> Sum + ways(Rest, Total - (Num * Coin)) end,
        0,
        lists:seq(0, Ways)
        ).



