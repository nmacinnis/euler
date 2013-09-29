-module(euler052).

-export([go/0]).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Res = scan_oom(1),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.

scan_oom(Oom) ->
    Lo = toolbox:pow(10, Oom),
    Hi = (toolbox:pow(10, Oom + 1) - 1) / 6,
    case iter(Lo, Hi) of
        false ->
            scan_oom(Oom + 1);
        N ->
            N
    end.

iter(Hi, Hi) ->
    false;
iter(N, Hi) ->
    case all_six(N) of
        true ->
            N;
        false ->
            iter(N + 1, Hi)
    end.

all_six(A) ->
    toolbox:has_same_digits(A, 6 * A) andalso
    toolbox:has_same_digits(A, 5 * A) andalso
    toolbox:has_same_digits(A, 4 * A) andalso
    toolbox:has_same_digits(A, 3 * A) andalso
    toolbox:has_same_digits(A, 2 * A).


