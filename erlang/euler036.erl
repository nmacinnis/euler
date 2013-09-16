-module(euler036).

-import(toolbox, []).

-export([go/0]).

go() ->
    Range = lists:seq(0, 999999),
    DBPals = lists:filter(fun(Num) -> is_double_base_palindrome(Num) end, Range),
    lists:sum(DBPals).

is_double_base_palindrome(Num) ->
    Numbin = toolbox:num_to_bin(Num),
    IsPal = toolbox:is_num_palindrome(Num),
    IsBinPal = toolbox:is_palindrome(Numbin),
    IsPal and IsBinPal.
