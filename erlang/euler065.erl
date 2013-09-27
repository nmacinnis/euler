-module(euler065).

-export([go/0]).

-import(toolbox, []).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Terms = lists:foldl(
            fun(K, Acc) -> Acc ++ [1, 2*K, 1] end,
            [],
            lists:seq(1,33)
            ),
    {FNum, FDen} = make_convergents(Terms),
    {Num, Den} = toolbox:reduce(FNum + 2*FDen, FDen),
    io:format("~p / ~p~n", [Num, Den]),
    Res = lists:sum(
        toolbox:integer_to_digits(Num)
        ),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.

make_convergents(Terms) ->
    RTerms = lists:reverse(Terms),
    [HTerm | TTerms] = RTerms,
    lists:foldl(
        fun(Term, {SNum, SDen}) ->
                Num = 1,
                Den = Term,
                NDen = Den * SDen + SNum,
                NNum = Num * SDen,
                %io:format("~p / (~p + ~p/~p) = ", [Num, Den, SNum, SDen]),
                {ONum, ODen} = toolbox:reduce(NNum, NDen),
                io:format("(~p / ~p)~n", [ONum, ODen]),
                {ONum, ODen}
        end,
        {1, HTerm},
        TTerms
        ).
