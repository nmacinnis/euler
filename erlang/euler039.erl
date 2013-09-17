-module(euler039).

-export([go/0]).

go() ->
    {_Max, P} = iterate_on_p(1, 0, 0),
    P.

iterate_on_p(P, Max, MaxP) when P > 1000 ->
    {Max, MaxP};
iterate_on_p(P, Max, MaxP) ->
    Count = iterate_on_slns(1, 2, P, 0),
    case erlang:max(Count, Max) of
        Count ->
            iterate_on_p(P + 1, Count, P);
        Max ->
            iterate_on_p(P + 1, Max, MaxP)
    end.


iterate_on_slns(A, B, P, Acc) ->
    case check_sln(A, B, P) of
        a_too_big ->
            Acc;
        b_too_big ->
            iterate_on_slns(A + 1, A + 1, P, Acc);
        sln ->
            iterate_on_slns(A + 1, A + 1, P, Acc + 1);
        too_small ->
            iterate_on_slns(A, B + 1, P, Acc)
    end.

check_sln(A, B, _P) when A > B ->
    a_too_big;
check_sln(A, B, P) ->
    A2 = math:pow(A, 2),
    B2 = math:pow(B, 2),
    C = P - (A + B),
    C2 = math:pow(C, 2),
    if
        A > C ->
            a_too_big;
        B > C ->
            b_too_big;
        (A2 + B2 > C2) ->
            b_too_big;
        (A2 + B2 == C2) ->
            sln;
        true ->
            too_small
    end.
