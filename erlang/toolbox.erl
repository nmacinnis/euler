-module(toolbox).

-export([reduce/2, gcd/2, lcm/2]).
-export([fact/1, pow/2, product/1]).
-export([integer_to_digits/1, digits_to_integer/1, sum_digits/1, permutate_digits/1]).
-export([reverse_str/1, num_to_bin/1]).
-export([boolean_to_integer/1]).
-export([is_palindrome/1, is_num_palindrome/1]).
-export([generate_primes/1, generate_primes/2]).
-export([prime_factorize/1, prime_factorize/2, reduce_factoring/1]).
-export([is_prime/2]).
-export([resilience/1, resilience/2, totient/1, totient/2, totient_ratio/1]).
-export([generate_triangle_numbers/1]).
-export([lr_truncate/1, rl_truncate/1]).
-export([find_pandigital/1]).
-export([is_pandigital/1, is_pandigital/2]).
-export([pentagonize/1, is_pentagonal/1]).
-export([triangulize/1, is_triangular/1]).
-export([hexagonize/1, is_hexagonal/1]).
-export([generate_fibs/1]).
-export([parse_roman/1, to_roman/1]).
-export([read_file/1]).
-export([reflect/3, line/2, angle/2]).
-export([tangent_slope/2, intersection/2]).

integer_to_digits(N) ->
    lists:map(
        fun(DigitStr) ->
                {Digit, []} = string:to_integer([DigitStr]),
                Digit
        end,
        erlang:integer_to_list(N)).

digits_to_integer(Digits) ->
    erlang:element(
        1,
        lists:foldr(
            fun(Digit, {Acc, Place}) -> {Acc + (Digit * Place), Place * 10} end,
            {0, 1},
            Digits
            )
        ).

boolean_to_integer(true) ->
    1;
boolean_to_integer(false) ->
    0.

sum_digits(N) ->
    lists:sum(integer_to_digits(N)).

fact(N) when N =< 1 ->
    1;
fact(N) ->
    N * fact(N - 1).

pow(N, P) ->
    erlang:trunc(math:pow(N, P)).

product(Numbers) ->
    lists:foldl(
        fun(N, Product) -> N * Product end,
        1,
        Numbers
        ).

reduce(Num, Den) ->
    Factor = gcd(Num, Den),
    {Num div Factor, Den div Factor}.

% http://rosettacode.org/wiki/Least_common_multiple#Erlang
gcd(A, 0) ->
    A;
gcd(A, B) ->
    gcd(B, A rem B).

lcm(A, B) ->
    abs(A * B div gcd(A, B)).

num_to_bin(Num) ->
    integer_to_list(Num, 2).

is_num_palindrome(Num) ->
    Numstr = erlang:integer_to_list(Num),
    is_palindrome(Numstr).

reverse_str(Str) ->
    lists:reverse(Str).

is_palindrome(Str) ->
    Str == lists:reverse(Str).

generate_primes(Limit) ->
    generate_primes(Limit, none).
generate_primes(Limit, none) ->
    generate_primes(Limit, ordsets:from_list([2]));
generate_primes(Limit, []) ->
    generate_primes(Limit, [2]);
generate_primes(Limit, Primes) ->
    Last = lists:last(Primes),
    case Limit =< Last of
        true ->
            Primes;
        false ->
            Min = Last,
            Max = erlang:min(Limit, Last * Last),
            io:format("collecting primes from ~p to ~p ~n", [Min, Max]),
            Space = lists:seq(Min, Max),
            NewPrimes = ordsets:filter(fun(N) -> is_prime(N, Primes) end, Space),
            Union = ordsets:union(Primes, NewPrimes),
            case Max of
                Limit ->
                    Union;
                Max ->
                    generate_primes(Limit, Union)
            end
    end.

is_prime(_N, []) ->
    true;
is_prime(N, [Head | _]) when (Head * Head) > N ->
    true;
is_prime(N, Primes) ->
    [Head | Rest] = Primes,
    (N rem Head =/= 0) and is_prime(N, Rest).

prime_factorize(N) ->
    Primes = generate_primes(N, none),
    prime_factorize(N, Primes).
prime_factorize(N, Primes) ->
    NPrimes = case N > (2 * lists:last(Primes)) of
        true ->
            generate_primes(N, Primes);
        false ->
            Primes
    end,
    {iter(N, NPrimes, []), NPrimes}.

iter(_N, [], Acc) ->
    Acc;
iter(N, Primes, Acc) ->
    [Head | Tail] = Primes,
    case (N rem Head) == 0 of
        true ->
            iter((N div Head), Primes, Acc ++ [Head]);
        false ->
            iter(N, Tail, Acc)
    end.

reduce_factoring(Factors) ->
    lists:foldl(
        fun(Factor, Keylist) ->
                case lists:keyfind(Factor, 1, Keylist) of
                    {Factor, Power} ->
                        lists:keyreplace(Factor, 1, Keylist, {Factor, Power + 1});
                    false ->
                        Keylist ++ [{Factor, 1}]
                end
        end,
        [],
        Factors
        ).

resilience(N) ->
    resilience(N, none).
resilience(N, Primes) ->
    NPrimes = generate_primes(N, Primes),
    PrimesLTN = lists:filter(
            fun(P) -> P =< N end,
            NPrimes
            ),
    Pr = product(PrimesLTN),
    totient_ratio(Pr, NPrimes).

totient_ratio(Pr) ->
    totient_ratio(Pr, [2]).
totient_ratio(Pr, Primes) ->
    {To, NPrimes} = totient(Pr, Primes),
    {{Pr, To, (To / (Pr - 1))}, NPrimes}.


totient(D) ->
    totient(D, [2]).
totient(D, Primes) ->
    {Factors, NPrimes} = prime_factorize(D, Primes),
    UniqueFactors = sets:to_list(sets:from_list(Factors)),
    Totient = erlang:trunc(
        lists:foldl(
            fun(Factor, Product) -> Product * (1 - (1 / Factor)) end,
            D,
            UniqueFactors
            )
        ),
    {Totient, NPrimes}.


lr_truncate(N) ->
    [_ | Rest] = erlang:integer_to_list(N),
    case Rest of
        [] ->
            [N];
        Rest ->
            {NRest, []} = string:to_integer(Rest),
            [N] ++ lr_truncate(NRest)
    end.

rl_truncate(N) ->
    Digits = erlang:integer_to_list(N),
    Body = lists:sublist(Digits, erlang:length(Digits) - 1),
    case Body of
        [] ->
            [N];
        Body ->
            {NBody, []} = string:to_integer(Body),
            [N] ++ rl_truncate(NBody)
    end.

is_pandigital(N) ->
    is_pandigital(N, lists:seq(0, 9)).

is_pandigital(N, Digits) ->
    NDigits = integer_to_digits(N),
    lists:sort(NDigits) == lists:sort(Digits).

generate_triangle_numbers(Count) ->
    {Numbers, _} = lists:mapfoldl(
        fun(X, Sum) -> {X + Sum, X + Sum} end,
        0,
        lists:seq(1, Count)
        ),
    Numbers.

permutate_digits([]) ->
    [[]];
permutate_digits(Digits) ->
    [
        [Head | Tail] || Head <- Digits, Tail <- permutate_digits(Digits -- [Head])
    ].

% from http://www.erlang.org/doc/programming_examples/list_comprehensions.html
% perms([]) -> [[]];
% perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].

find_pandigital(9876543210) ->
    none;
find_pandigital(Last) ->
    Next = Last + 1,
    case toolbox:is_pandigital(Next) of
        true ->
            Next;
        false ->
            find_pandigital(Next)
    end.

pentagonize(N) ->
    (N * ((3 * N) - 1)) div 2.

triangulize(N) ->
    (N * (N + 1)) div 2.

hexagonize(N) ->
    N * ((2 * N) - 1).

is_pentagonal(N) when N > 0 ->
    X = ((0.5 + math:sqrt(0.25 + (6 * N))) / 3),
    X == erlang:trunc(X).

is_triangular(N) when N > 0 ->
    X = math:sqrt((8 * N) + 1),
    X == erlang:trunc(X).

is_hexagonal(N) when N > 0 ->
    X = (math:sqrt((8 * N) + 1) + 1) / 4,
    X == erlang:trunc(X).

generate_fibs(Max) ->
    generate_fibs(1, 1, [1, 1], Max).
generate_fibs(P1, P2, List, Max) ->
    case P1 + P2 < Max of
        true ->
            generate_fibs(
                P2,
                P1 + P2,
                List ++ [P1 + P2],
                Max
            );
        _ ->
            List
    end.

parse_roman(Chars) ->
    Subtractives = [{4, "IV"}, {9, "IX"}, {40, "XL"}, {90, "XC"}, {400, "CD"}, {900, "CM"}],
    {Sum, OutStr} = lists:foldl(
            fun({Value, Repr}, {Sum, OutStr}) ->
                    case contains_subtractive(OutStr, Repr) of
                        nomatch ->
                            {Sum, OutStr};
                        _ ->
                            {Sum + Value, remove_subtractive(OutStr, Repr)}
                    end
            end,
            {0, Chars},
            Subtractives
            ),
    %io:format("~p~n", [OutStr]),
    lists:foldl(
        fun(Char, Acc) ->
                Acc + case Char of
                    $I ->
                        1;
                    $V ->
                        5;
                    $X ->
                        10;
                    $L ->
                        50;
                    $C ->
                        100;
                    $D ->
                        500;
                    $M ->
                        1000
                end
        end,
        Sum,
        OutStr
        ).

contains_subtractive(String, Subtractive) ->
    re:run(String, Subtractive).

remove_subtractive(String, Subtractive) ->
    re:replace(String, Subtractive, "", [{return, list}]).

to_roman(Int) ->
    Hi = convert_roman((Int div 100), $C, $D, $M),
    Med = convert_roman(((Int rem 100) div 10), $X, $L, $C),
    Low = convert_roman((Int rem 10), $I, $V, $X),
    Hi ++ Med ++ Low.

convert_roman(Int, One, Five, Ten) ->
    if
        (Int div 10) > 0 ->
            [ Ten | convert_roman((Int - 10), One, Five, Ten) ];
        Int == 9 ->
            [ One, Ten ];
        (Int div 5) > 0 ->
            [ Five | convert_roman((Int - 5), One, Five, Ten) ];
        Int == 4 ->
            [ One, Five ];
        Int > 0 ->
            [ One | convert_roman((Int - 1), One, Five, Ten) ];
        true ->
            []
    end.

read_file(File) ->
    {ok, Data} = file:read_file(File),
    Str = erlang:binary_to_list(Data),
    re:split(Str, "\n", [{return, list}]).



p(Base, Power) -> math:pow(Base, Power).

reflect(Intersection, {LineIncM, _LineIncB}, Ellipse) ->
    TSlope = tangent_slope(Ellipse, Intersection),
    ThTSlope = math:atan(TSlope),
    ThInc = angle(LineIncM, TSlope),
    ThRef = ThTSlope + math:pi() - ThInc,
    RefSlope = math:tan(ThRef),
    LineRef = line(RefSlope, Intersection),
    LineRef.


line({Ax, Ay}, {Bx, By}) ->
    M = (By - Ay) / (Bx - Ax),
    line(M, {Bx, By});
line(M, {Bx, By}) ->
    B = By - M * (Bx),
    {M, B}.

tangent_slope({EllipseA, EllipseB}, {X, Y}) ->
    -(p(EllipseB, 2) / p(EllipseA, 2)) * (X / Y).

angle(Slope1, Slope2) ->
    math:atan( (Slope1 - Slope2) / (1 + (Slope1 * Slope2)) ).

intersection({EllipseA, EllipseB}, {LineM, LineB}) ->
    A = p(LineM, 2) + ( p(EllipseB, 2) / p(EllipseA, 2)),
    B = 2 * LineM * LineB,
    C = p(LineB, 2) - p(EllipseB, 2),
    Zero1 = (-B + math:sqrt(p(B, 2) - 4*A*C)) / (2*A),
    Zero2 = (-B - math:sqrt(p(B, 2) - 4*A*C)) / (2*A),
    Intersection1 = {Zero1, (LineM * Zero1) + LineB},
    Intersection2 = {Zero2, (LineM * Zero2) + LineB},
    {Intersection1, Intersection2}.

