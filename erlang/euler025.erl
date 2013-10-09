-module(euler025).

-export([go/0]).

-import(toolbox, []).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Res = iter(0, 1, 1000, 1),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.

iter(N1, N2, Len, Acc) ->
    case erlang:length(toolbox:integer_to_digits(N1 + N2)) of
        Len ->
            Acc + 1;
        _ ->
            iter(N2, N1 + N2, Len, Acc + 1)
    end.

