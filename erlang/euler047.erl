-module(euler047).

-export([go/0]).

go() ->
    Start = erlang:universaltime_to_posixtime(erlang:universaltime()),
    Res = iter(2, [2], 0, 4),
    End = erlang:universaltime_to_posixtime(erlang:universaltime()),
    io:format("~p found in ~ps~n", [Res, End-Start]),
    Res.


iter(N, KnownPrimes, ConsecutiveKFactorComposites, K) ->
    {NFactors, NPrimes} = toolbox:prime_factorize(N, KnownPrimes),
    PC = case NFactors of
        [N] ->
            prime;
        _ ->
            composite
    end,
    case PC of
        prime ->
            iter(N + 1, NPrimes, 0, K);
        composite ->
            DistinctComposites = erlang:length(toolbox:reduce_factoring(NFactors)),
            if
                (DistinctComposites == K) and (ConsecutiveKFactorComposites == (K - 1)) ->
                    N - (K - 1);
                (DistinctComposites == K) ->
                    iter(N + 1, NPrimes, ConsecutiveKFactorComposites + 1, K);
                true ->
                    iter(N + 1, NPrimes, 0, K)
            end
    end.

