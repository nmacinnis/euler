-module(euler042).

-export([go/0]).

-import(toolbox, []).

go() ->
    {ok, Words_txt} = file:open("words.txt", read),
    {ok, Data} = file:read_line(Words_txt),
    UnquotedData = re:replace(Data, "\"", "", [global, {return, list}]),
    Words = re:split(UnquotedData, ",", [{return, list}]),
    lists:foreach(fun(Word) -> io:format("~p~n", [Word]) end, Words),
    %Keys = lists:map(fun(Int) -> {erlang:binary_to_list(<<Int>>), Int - 64} end, "ABCDEFGHIJKLMNOPQRSTUVWXYZ"),
    %Keys = lists:map(fun(Int) -> {Int, Int - 64} end, "ABCDEFGHIJKLMNOPQRSTUVWXYZ"),
    Triangles = toolbox:generate_triangle_numbers(1000),
    erlang:length(
        lists:filter(
            fun(Word) -> lists:member(word_value(Word), Triangles) end,
            Words
            )
        ).

word_value(Word) ->
    lists:foldl(
        fun(LetterInt, Sum) -> Sum + (LetterInt - 64) end,
        0,
        Word
        ).

