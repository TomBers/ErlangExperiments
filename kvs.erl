-module(kvs).
-export([start/0, store/2, lookup/1, list/0]).

start() -> register(kvs, spawn(fun() -> loop() end)).

store(Key, Value) -> rpc({store, Key, Value}).

lookup(Key) -> rpc({lookup, Key}).

list() -> rpc({list}).

rpc(Q) ->
    kvs ! {self(), Q},
    receive
        {kvs, {ok, Dat}} -> Dat;
        {kvs, Reply} -> Reply
    end.

loop() ->
    receive
        {From, {store, Key, Value}} ->
            put(Key, {ok, Value}),
            From ! {kvs, true},
            loop();
        {From, {lookup, Key}} ->
            From ! {kvs, get(Key)},
            loop();
        {From, {list}} ->
            From ! {kvs, get()},
            loop()
    end.
