-module(hello).
-export([start/0]).

start() -> bob().

bob() -> io:format("hello world~n").
