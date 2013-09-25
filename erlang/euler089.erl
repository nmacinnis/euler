-module(euler089).

-export([go/0]).

-import(toolbox, []).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Data = toolbox:read_file("roman.txt"),
    Res = lists:foldl(
        fun(Roman, Sum) ->
                L1 = erlang:length(Roman),
                L2 = erlang:length(roman_to_int_to_roman(Roman)),
                Sum + (L1 - L2) end,
        0,
        Data
        ),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.


roman_to_int_to_roman(Roman) ->
    toolbox:to_roman(toolbox:parse_roman(Roman)).

