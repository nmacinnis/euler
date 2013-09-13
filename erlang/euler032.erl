-module(euler032).

-export([go/0]).

go() ->
    find_and_sum_pandigitals(9).

strcompare(A, B) when length(A) > length(B) ->
    longer;
strcompare(A, B) when length(A) < length(B) ->
    shorter;
strcompare(A, B) ->
    case lists:reverse(lists:sort(A)) == B of
        true ->
            equal;
        _ ->
            nequal
    end.

inner(Multiplier, _Multiplicand, _Max, MaxFactor, AccSet) when Multiplier >= MaxFactor ->
    AccSet;
inner(Multiplier, Multiplicand, Max, MaxFactor, AccSet) when Multiplicand >= MaxFactor ->
    inner(Multiplier + 1, 1, Max, MaxFactor, AccSet);
inner(Multiplier, Multiplicand, Max, MaxFactor, AccSet) ->
    Product = Multiplier * Multiplicand,
    %io:format("? ~p * ~p = ~p~n", [Multiplier, Multiplicand, Product]),
    EqnAsList = lists:append([ erlang:integer_to_list(Multiplicand),
                              erlang:integer_to_list(Multiplier),
                              erlang:integer_to_list(Product)]),
    MaxString = erlang:integer_to_list(Max),
    case strcompare(EqnAsList, MaxString) of
        longer ->
            inner(Multiplier + 1, 1, Max, MaxFactor, AccSet);
        shorter ->
            inner(Multiplier, Multiplicand + 1, Max, MaxFactor, AccSet);
        equal ->
            io:format("--> ~p * ~p = ~p~n", [Multiplier, Multiplicand, Product]),
            inner(Multiplier, Multiplicand + 1, Max, MaxFactor, sets:add_element(Product, AccSet));
        _ ->
            inner(Multiplier, Multiplicand + 1, Max, MaxFactor, AccSet)
    end.

find_pandigitals(Digits) ->
    {Max, _} = string:to_integer(lists:concat(lists:seq(Digits, 1, -1))),
    MaxFactor = trunc(math:sqrt(Max/10)),
    sets:to_list(inner(1, 1, Max, MaxFactor, sets:new())).

find_and_sum_pandigitals(Digits) ->
    Products = find_pandigitals(Digits),
    io:format("unique products: ~p~n", [Products]),
    lists:sum(Products).

