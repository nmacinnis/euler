-module(euler144).

-export([go/0]).

-import(toolbox, []).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    EllipseA = 5,
    EllipseB = 10,
    Ellipse = {EllipseA, EllipseB},
    StartPoint = {0, 10.1},
    First = {1.4, -9.6},
    Line = toolbox:line(StartPoint, First),
    Res = iter(StartPoint, Line, Ellipse, 0),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.

iter(StartPoint, Line, Ellipse, Acc) ->
    {PointA, PointB} = toolbox:intersection(Ellipse, Line),
    NextPoint = filter_known_point(PointA, PointB, StartPoint),
    case exits(NextPoint) of
        true ->
            Acc;
        false ->
            LineRef = toolbox:reflect(NextPoint, Line, Ellipse),
            iter(NextPoint, LineRef, Ellipse, Acc + 1)
    end.

exits({Ix, Iy}) ->
    ((-0.01 =< Ix) and (Ix =< 0.01)) and (Iy > 0).

filter_known_point({Ax, Ay}, {Bx, By}, {Kx, Ky}) ->
    case (six_places(Ax) == six_places(Kx)) and
        (six_places(Ay) == six_places(Ky)) of
        true ->
            {Bx, By};
        false ->
            {Ax, Ay}
    end.

six_places(F) ->
    erlang:round(F * 1000000) / 1000000.

