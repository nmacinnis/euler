-module(euler037).

-import(toolbox, []).

-export([go/0]).

go() ->
    Primes = toolbox:generate_primes(10, none),
    TruncatablePrimes = gen_primes_and_scan(10, Primes, 0),
    lists:sum(TruncatablePrimes).

gen_primes_and_scan(Min, Primes, Count) ->
    Max = 10 * Min,
    NPrimes = toolbox:generate_primes(Max, Primes),
    {LRTPrimes, RLTPrimes} = scan_oom(Min, Max, NPrimes),
    case LRTPrimes of
        [] ->
            [];
        LRTPrimes ->
            io:format("~p lrt primes and ~p rlt primes in this gen~n", [erlang:length(LRTPrimes), erlang:length(RLTPrimes)]),
            case Count + length(RLTPrimes) of
                11 ->
                    RLTPrimes;
                Sum ->
                    RLTPrimes ++ gen_primes_and_scan(Max, NPrimes, Sum)
            end
    end.

scan_oom(Min, Max, Primes) ->
    Range = lists:filter(fun(P) -> (P >= Min) and (P =< Max) end, Primes),
    LRTPrimes = lists:filter(fun(P) -> is_lr_truncatable_prime(P, Primes) end, Range),
    RLTPrimes = case LRTPrimes of
        [] ->
            [];
        LRTPrimes ->
            lists:filter(fun(P) -> is_rl_truncatable_prime(P, Primes) end, LRTPrimes)
    end,
    {LRTPrimes, RLTPrimes}.

is_lr_truncatable_prime(N, _Primes) when N < 10 ->
    false;
is_lr_truncatable_prime(N, Primes) ->
    Truncs = toolbox:lr_truncate(N),
    lists:all(fun(T) -> lists:member(T, Primes) end, Truncs).

is_rl_truncatable_prime(N, _Primes) when N < 10 ->
    false;
is_rl_truncatable_prime(N, Primes) ->
    Truncs = toolbox:rl_truncate(N),
    lists:all(fun(T) -> lists:member(T, Primes) end, Truncs).
