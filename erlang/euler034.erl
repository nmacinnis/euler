-module(euler034).

-import(toolbox, []).

-export([go/0]).

go() ->
    find_curious_numbers(3, 10000000, 0).


find_curious_numbers(X, Max, Sum) when X == Max ->
    Sum;
find_curious_numbers(X, Max, Sum) ->
    NewSum = case is_curious(X) of
        true ->
            io:format("~p was curious~n", [X]),
            Sum + X;
        _ ->
            Sum
    end,
    find_curious_numbers(X + 1, Max, NewSum).

is_curious(X) ->
    Digits = toolbox:integer_to_digits(X),
    Facts = fun(Digit) -> toolbox:fact(Digit) end,
    lists:sum(lists:map(Facts, Digits)) == X.
