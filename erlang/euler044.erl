-module(euler044).

-export([go/0]).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Res1 = go1(),
    Middle = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps via range guess~n", [Res1, Middle-Start]),
    Res2 = go2(),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps via math approach~n", [Res2, End-Middle]),
    Res2.

go1() ->
    Pentagonals = lists:map(
            fun(N) -> toolbox:pentagonize(N) end,
            lists:seq(1, 4000)
            ),
    lists:min(
        [ Pk - Pj || Pj <- Pentagonals, Pk <- Pentagonals--[Pj], (Pk > Pj) andalso toolbox:is_pentagonal(Pk - Pj) andalso toolbox:is_pentagonal(Pj + Pk) ]
        ).

go2() ->
    iter(1, 2).

iter(J, J) ->
    iter(1, J + 1);
iter(I, J) ->
    Pi = toolbox:pentagonize(I),
    Pj = toolbox:pentagonize(J),
    Pk = Pi + Pj, % Pk - Pj is pentagonal
    Pl1 = Pk + Pj, % Pk + Pj is pentagonal
    Pl2 = Pk + Pi, % maybe I is bigger than J
    case toolbox:is_pentagonal(Pk) of
        true ->
            case toolbox:is_pentagonal(Pl1) of
                true ->
                    Pi;
                false ->
                    case toolbox:is_pentagonal(Pl2) of
                        true ->
                            Pj;
                        false ->
                            iter(I + 1, J)
                    end
            end;
        false ->
            iter(I + 1, J)
    end.
