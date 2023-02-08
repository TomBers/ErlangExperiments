-module(area_server0).
-export([loop/0]).

loop() ->
    receive
        {From, {rectangle, Width, Ht}} ->
            From ! Width * Ht,
            loop();
        {From, {square, Side}} ->
            From ! Side * Side,
            loop()
    end.
