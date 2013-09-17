-module(euler038).

-export([go/0]).

go() ->
    Digits = lists:seq(1, 9),
    find_pandigital_multiples(1, 0, Digits).


find_pandigital_multiples(9999, Max, _Digits) ->
    Max;
find_pandigital_multiples(N, Max, Digits) ->
    case is_pandigital_multiple(N, 1, Digits) of
        {true, PanDigits} ->
            {Pan, []} = string:to_integer(lists:concat(PanDigits)),
            io:format("found ~p~n", [Pan]),
            find_pandigital_multiples(N + 1, erlang:max(Pan, Max), Digits);
        {false, _} ->
            find_pandigital_multiples(N + 1, Max, Digits)
    end.


is_pandigital_multiple(_M, _N, Digits) when erlang:length(Digits) == 0 ->
    {true, []};
is_pandigital_multiple(Multiple, N, Digits) ->
    %io:format("checking ~p @ ~p~n", [Multiple, N]),
    DigitSet = sets:from_list(Digits),
    Product = Multiple * N,
    ProductDigits = toolbox:integer_to_digits(Product),
    PDSet = sets:from_list(ProductDigits),
    case (lists:sort(sets:to_list(PDSet)) == lists:sort(ProductDigits)) and (sets:is_subset(PDSet, DigitSet)) of
        true ->
            {IsPD, NextDigits} = is_pandigital_multiple(Multiple, N + 1, sets:to_list(sets:subtract(DigitSet, PDSet))),
            {IsPD, ProductDigits ++ NextDigits};
        _ ->
            %io:format("~p is not a subset of ~p~n", [ProductDigits, Digits]),
            {false, []}
    end.

