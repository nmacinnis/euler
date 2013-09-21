-module(euler049).

-export([go/0]).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    LowPrimes = toolbox:generate_primes(999, none),
    Primes = toolbox:generate_primes(10000, LowPrimes) -- LowPrimes,
    Sequences = [ {A, B, C} ||
        A <- Primes,
        B <- Primes -- [A],
        C <- Primes -- [A, B],
            (A < B) andalso (B < C) andalso ((B - A) == (C - B)) ],
    Res = lists:filtermap(
        fun({A, B, C}) ->
                Ad = toolbox:integer_to_digits(A),
                Bd = toolbox:integer_to_digits(B),
                Cd = toolbox:integer_to_digits(C),
                case lists:sort(Ad) == lists:sort(Bd) andalso
                    lists:sort(Ad) == lists:sort(Cd) of
                    true ->
                        {true, toolbox:digits_to_integer(Ad ++ Bd ++ Cd)};
                    false ->
                        false
                end
        end,
        Sequences
        ),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.
