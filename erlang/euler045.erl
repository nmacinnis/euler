-module(euler045).

-export([go/0]).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Res = iter(144),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.


iter(N) ->
    Hn = toolbox:hexagonize(N),
    case toolbox:is_pentagonal(Hn) andalso toolbox:is_triangular(Hn) of
        true ->
            Hn;
        false ->
            iter(N + 1)
    end.

