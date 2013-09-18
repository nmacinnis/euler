-module(euler040).

-export([go/0]).

-import(toolbox, []).


go() ->
    lists:foldl(
        fun(Oom, Acc) -> get_nth_digit(pow(10, Oom)) * Acc end,
        1,
        lists:seq(0, 6)
        ).

get_nth_digit(N) ->
    {Oom, DigitsBelowOom} = get_oom_and_digits(N, 0, 0),
    get_nth_digit_of_oom(N - DigitsBelowOom, Oom).

get_nth_digit_of_oom(N, Oom) ->
    io:format("getting ~pth digit of oom ~p: ", [N, Oom]),
    DigitsPerNumber = Oom + 1,
    NumberIndex = (N - 1) div DigitsPerNumber,
    DigitIndex = (N - 1) rem DigitsPerNumber,
    Number = pow(10, Oom) + NumberIndex,
    NumberDigits = toolbox:integer_to_digits(Number),
    Digit = lists:nth(DigitIndex + 1, NumberDigits),
    io:format("~p~n", [Digit]),
    Digit.

get_oom_and_digits(N, Oom, DigitsBelowOom) ->
    NumbersInOom = 9 * pow(10, Oom),
    DigitsInOom = NumbersInOom * (Oom + 1),
    TotalDigits = DigitsInOom + DigitsBelowOom,
    IsNInOom = (N > DigitsBelowOom) and (N =< TotalDigits),
    case IsNInOom of
        true ->
            {Oom, DigitsBelowOom};
        false ->
            get_oom_and_digits(N, Oom + 1, TotalDigits)
    end.

pow(N, P) ->
    erlang:trunc(math:pow(N, P)).
