module InfoTests exposing (main)

import Test exposing (describe, test)
import Expect
import Test.Runner.Html exposing (run)
import Info exposing (..)


resetTest =
    describe "reset"
        [ test "output is infoEasy when input is Easy" <|
            \() ->
                reset Easy |> Expect.equal (Info Easy 100 0 30 0 60)
        , test "output is infoMedium when input is Medium" <|
            \() ->
                reset Medium |> Expect.equal (Info Medium 200 0 30 0 30)
        , test "output is infoHard when input is Hard" <|
            \() ->
                reset Hard |> Expect.equal (Info Hard 300 0 20 0 15)
        ]


tickTest =
    describe "tick"
        [ let
            infoInput =
                Info Easy 0 0 0 0 0

            infoOutput =
                Info Easy 0 0 0 1 0
          in
            test "output is infoOutput when input is infoInput" <|
                \() ->
                    tick infoInput |> Expect.equal infoOutput
        ]


nextTest =
    describe "next"
        [ let
            infoInput =
                Info Easy 0 0 0 1 0

            infoOutput =
                Info Easy 0 1 0 0 0
          in
            test "output is infoOutput when input is infoInput" <|
                \() ->
                    next infoInput |> Expect.equal infoOutput
        ]


isWonTest =
    describe "isWon"
        [ let
            infoInput =
                Info Easy 10 0 0 0 0
          in
            test "output is True when input is 30 and infoInput" <|
                \() ->
                    isWon 30 infoInput |> Expect.equal True
        , let
            infoInput =
                Info Easy 100 0 1 0 0
          in
            test "output is False when input is 30 and infoInput" <|
                \() ->
                    isWon 30 infoInput |> Expect.equal False
        ]


isLostTest =
    describe "isLost"
        [ let
            infoInput =
                Info Easy 0 20 10 0 0
          in
            test "output is True when input and False" <|
                \() ->
                    isLost infoInput |> Expect.equal True
        , let
            infoInput =
                Info Easy 0 20 21 0 0
          in
            test "output is False when input and True" <|
                \() ->
                    isLost infoInput |> Expect.equal False
        ]


main =
    run <|
        describe "InfoModule"
            [ resetTest
            , tickTest
            , nextTest
            , isWonTest
            , isLostTest
            ]
