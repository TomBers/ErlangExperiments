-module(list_comp).
-export([mp/2, rd/2]).

mp(L, FN) -> [FN(X) || X <- L].

rd([], ACC, _) -> ACC;
rd([H | T], ACC, FN) -> rd(T, ACC + FN(H), FN).

rd(L, FN) -> rd(L, 0, FN).
