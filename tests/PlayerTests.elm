module PlayerTests exposing (main)

import Test exposing (describe, test)
import Expect
import Test.Runner.Html exposing (run)
import Player exposing (..)


playerFixture1 =
    Player [ 2, 3 ] 5 0 ( 0, 0 ) ( 0, 0 )


playerFixture2 =
    Player [ 7, 2, 3 ] 5 0 ( 0, 0 ) ( 0, 0 )


playerFixture3 =
    Player [] 5 0 ( 0, 0 ) ( 0, 0 )


playerFixture4 =
    Player [ 2, 7 ] 5 0 ( 0, 0 ) ( 0, 0 )


addHandTest =
    describe "addHand"
        [ test "output is playerFixture2 when input is 7 and playerFixture1" <|
            \() ->
                addHand 7 playerFixture1 |> Expect.equal playerFixture2
        ]


resetHandTest =
    describe "addHand"
        [ test "output is playerFixture3 when input is playerFixture1" <|
            \() ->
                resetHand playerFixture1 |> Expect.equal playerFixture3
        ]


countHandTest =
    describe "countHand"
        [ test "output is 2 when input is playerFixture1" <|
            \() ->
                countHand playerFixture1 |> Expect.equal 2
        ]


sumHandTest =
    describe "sumHand"
        [ test "output is 5 when input is playerFixture1" <|
            \() ->
                sumHand playerFixture1 |> Expect.equal 5
        ]


factorTest =
    describe "factor"
        [ test "output is 1 when input is playerFixture1" <|
            \() ->
                factor playerFixture1 |> Expect.equal 1
        , test "output is 2 when input is playerFixture2" <|
            \() ->
                factor playerFixture2 |> Expect.equal 2
        ]


remTest =
    describe "rem"
        [ test "output is 0 when input is playerFixture1" <|
            \() ->
                Player.rem playerFixture1 |> Expect.equal 0
        , test "output is 4 when input is playerFixture3" <|
            \() ->
                Player.rem playerFixture4 |> Expect.equal 4
        ]


isGoalReachTest =
    describe "isGoalReach"
        [ test "output is True when input is playerFixture1" <|
            \() ->
                isGoalReach playerFixture1 |> Expect.equal True
        , test "output is False when input is playerFixture3" <|
            \() ->
                isGoalReach playerFixture3 |> Expect.equal False
        , test "output is False when input is playerFixture4" <|
            \() ->
                isGoalReach playerFixture4 |> Expect.equal False
        ]


updateComboTest =
    describe "updateCombo"
        [ let
            player1 =
                Player [ 1, 2, 3 ] 3 0 ( 0, 0 ) ( 0, 0 )

            player2 =
                Player [ 1, 2, 3 ] 3 0 ( 3, 0 ) ( 2, 0 )
          in
            test "output is player2 when input is player1" <|
                \() ->
                    updateCombo player1 |> Expect.equal player2
        , let
            player1 =
                Player [ 1, 2, 3 ] 3 0 ( 3, 0 ) ( 2, 0 )

            player2 =
                Player [ 1, 2, 3 ] 3 0 ( 3, 1 ) ( 2, 1 )
          in
            test "output is player2 when input is player1" <|
                \() ->
                    updateCombo player1 |> Expect.equal player2
        ]


calculateComboTest =
    describe "calculateCombo"
        [ let
            player1 =
                Player [] 0 0 ( 0, 0 ) ( 0, 0 )
          in
            test "output is 0 when input is player1" <|
                \() ->
                    calculateCombo player1 |> Expect.equal 0
        , let
            player1 =
                Player [] 0 0 ( 4, 3 ) ( 2, 3 )
          in
            test "output is 20 when input is player1" <|
                \() ->
                    calculateCombo player1 |> Expect.equal 20
        ]


updatePointTest =
    describe "updatePoint"
        [ let
            player1 =
                Player [] 3 0 ( 0, 0 ) ( 0, 0 )

            player2 =
                Player [] 3 3 ( 0, 0 ) ( 0, 0 )
          in
            test "output is  player2 when input is player1" <|
                \() ->
                    updatePoint player1 |> Expect.equal player2
        , let
            player1 =
                Player [] 1 20 ( 4, 3 ) ( 2, 3 )

            player2 =
                Player [] 1 41 ( 4, 3 ) ( 2, 3 )
          in
            test "output is player2 when input is player1" <|
                \() ->
                    updatePoint player1 |> Expect.equal player2
        ]


main =
    run <|
        describe "playerModule"
            [ addHandTest
            , resetHandTest
            , countHandTest
            , sumHandTest
            , factorTest
            , remTest
            , isGoalReachTest
            , updateComboTest
            , calculateComboTest
            , updatePointTest
            ]
