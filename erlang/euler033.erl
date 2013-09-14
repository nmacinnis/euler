-module(euler033).

-export([go/0]).

go() ->
    Fractions = find_canceling_fractions(10, 99, 10, 99),
    io:format("~p~n", [Fractions]),
    lists:foldl(fun({Num, Den}, Prod) -> (Den/Num) * Prod end, 1, Fractions).

find_canceling_fractions(MinNum, MaxNum, MinDen, MaxDen) ->
    Numerators = lists:seq(MinNum, MaxNum),
    Denominators = lists:seq(MinDen, MaxDen),
    DeepMatches = lists:filtermap(
            fun(Num) -> get_canceling_pairs(Num, Denominators) end,
            Numerators
            ),
    lists:flatten(DeepMatches).

get_canceling_pairs(Num, Denominators) ->
    case lists:filtermap(
            fun(Den) ->
                    case is_canceling(Num, Den) of
                        true -> {true, {Num, Den}};
                        false -> false
                    end
            end,
            Denominators
            ) of
        [] ->
            false;
        Values ->
            {true, Values}
    end.

is_canceling(Num, Den) when (Num == Den) or (Num/Den > 1) ->
    false;
is_canceling(Num, Den) ->
    % identify common digits
    NumStr = erlang:integer_to_list(Num),
    DenStr = erlang:integer_to_list(Den),
    Int = sets:to_list(
            sets:intersection(
                sets:from_list(NumStr),
                sets:from_list(DenStr)
                )
            ),
    Matches = lists:any(
            fun(Elem) -> Elem == (Num/Den) end,
            lists:map(
                fun(Elem) -> quotient_after_removing_char(NumStr, DenStr, Elem) end,
                Int
                )
            ),
    if
        Matches ->
            io:format("~p/~p cancel ~p matches: ~p~n", [NumStr, DenStr, Int, Matches]);
        true ->
            whatever
    end,
    Matches.

quotient_after_removing_char(_NumStr, _DenStr, C) when C == $0 ->
    -1;
quotient_after_removing_char(NumStr, DenStr, C) ->
    {NewNum, []} = string:to_integer(lists:delete(C, NumStr)),
    {NewDen, []} = string:to_integer(lists:delete(C, DenStr)),
    case NewDen of
        0 ->
            -1;
        _ ->
            NewNum/NewDen
    end.

