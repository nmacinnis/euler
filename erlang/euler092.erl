-module(euler092).

-export([go/0]).

-import(toolbox, []).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    {Ones, ENs} = collect_one_and_en_chains(1, sets:from_list([1]), sets:from_list([89])),
    Res = erlang:length(
        lists:filter(
            fun(N) -> one_or_eighty_nine(sum_square_digits(N), Ones, ENs) == en end,
            lists:seq(1,9999999)
            )
        ),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.

collect_one_and_en_chains(568, Ones, ENs) ->
    {Ones, ENs};
collect_one_and_en_chains(N, Ones, ENs) ->
    {NOnes, NENs} = add_to_ssd_chain(N, Ones, ENs, sets:new()),
    collect_one_and_en_chains(N + 1, NOnes, NENs).


one_or_eighty_nine(N, Ones, ENs) ->
    case sets:is_element(N, Ones) of
        true ->
            one;
        false ->
            case sets:is_element(N, ENs) of
                true ->
                    en;
                false ->
                    false
            end
    end.

add_to_ssd_chain(N, Ones, ENs, Unks) ->
    case one_or_eighty_nine(N, Ones, ENs) of
        one ->
            {sets:union(Ones, Unks), ENs};
        en ->
            {Ones, sets:union(ENs, Unks)};
        false ->
            SSD = sum_square_digits(N),
            add_to_ssd_chain(SSD, Ones, ENs, sets:add_element(N, Unks))
    end.




sum_square_digits(N) ->
    lists:sum(
        lists:map(
            fun(I) -> toolbox:pow(I, 2) end,
            toolbox:integer_to_digits(N)
            )
        ).

