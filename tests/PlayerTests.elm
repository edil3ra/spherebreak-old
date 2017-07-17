module PlayerTests exposing (main)

import Test exposing (describe, test)
import Expect
import Test.Runner.Html exposing (run)

import Player exposing (..)





addHandTest =
    describe "addHand"
        [ test "output is 1 when input is 1" <|
            \() ->
                1 |> Expect.equal 1
        ]


        
main =
    run <|
        describe "playerModule"
            [ addHandTest
                  
            ]
