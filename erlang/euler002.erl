-module(euler_002).

-export([gor/0]).

gor() ->
    List = [1,2],
    lists:sum(
        [B ||
            B <- make_fibs(1, 2, List, 4000000),
            B rem 2 =:= 0
        ]
    ).

make_fibs(P1, P2, List, Max) ->
    case P1 + P2 < Max of
        true ->
            make_fibs(
                P2, 
                P1 + P2, 
                List ++ [P1 + P2],
                Max
            );
        _ ->
            List
    end.


