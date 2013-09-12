-module(euler055).

-export([go/0]).

go() ->
    count_lychrels(lists:seq(10, 10000), 50).

reverse_num(Num) ->
    {Revnum, _} = string:to_integer(lists:reverse(erlang:integer_to_list(Num))),
    Revnum.

is_palindrome(Num) ->
    Num == reverse_num(Num).

is_lychrel(Num, Depth, Max_depth) when Depth < Max_depth ->
    case is_palindrome(Num) of
        true ->
            false;
        _ ->
            is_lychrel(Num + reverse_num(Num), Depth + 1, Max_depth)
    end;
is_lychrel(_, _, _) ->
    true.

count_lychrels(List, Max_depth) ->
    Filter = fun(Elem) -> is_lychrel(Elem + reverse_num(Elem), 1, Max_depth) end,
    string:len(lists:filter(Filter, List)).



