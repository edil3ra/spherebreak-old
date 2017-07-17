module CoinTests exposing (main)

import Test exposing (describe, test)
import Expect
import Test.Runner.Html exposing (run)
import Coin exposing (..)
import Debug


coreFixture1 : Coin
coreFixture1 =
    Core (CoreCoin 1)


coreFixture2 : Coin
coreFixture2 =
    Core (CoreCoin 2)


entryFixture1 : Coin
entryFixture1 =
    Entry (EntryCoin 1 False)


entryFixture2 : Coin
entryFixture2 =
    Entry (EntryCoin 1 True)


borderFixture1 : Coin
borderFixture1 =
    Border (BorderCoin 1 True True 1)


borderFixture2 : Coin
borderFixture2 =
    Border (BorderCoin 1 True False 1)

borderFixture3 : Coin
borderFixture3 =
    Border (BorderCoin 1 False False 1)


valueTest =
    describe "value"
        [ test "output is 1 when input is coreFixture" <|
            \() ->
                value coreFixture1 |> Expect.equal 1
        , test "output is 1 when input is entryFixture1" <|
            \() ->
                value entryFixture1 |> Expect.equal 1
        , test "output is 1 when input is borderFixture1" <|
            \() ->
                value borderFixture1 |> Expect.equal 1
        ]


aliveTest =
    describe "alive"
        [ test "output is True when input is coreFixture" <|
            \() ->
                alive coreFixture1 |> Expect.equal True
        , test "output is True when input is entryFixture1" <|
            \() ->
                alive entryFixture1 |> Expect.equal True
        , test "output is True when input is borderFixture1" <|
            \() ->
                alive borderFixture1 |> Expect.equal True
        ]


counterTest =
    describe "counter"
        [ test "output is True when input is coreFixture" <|
            \() ->
                counter coreFixture1 |> Expect.equal Nothing
        , test "output is True when input is entryFixture1" <|
            \() ->
                counter entryFixture1 |> Expect.equal Nothing
        , test "output is True when input is borderFixture1" <|
            \() ->
                counter borderFixture1 |> Expect.equal (Just 1)
        ]


isHitTest =
    describe "isHit"
        [ test "output is False when input is coreFixture1" <|
          \() ->
              isHit coreFixture1 |> Expect.equal False
          , test "output is False when input is entryFixture1" <|
          \() ->
              isHit entryFixture1 |> Expect.equal False
        , test "output is False when input is borderFixture1" <|
          \() ->
              isHit borderFixture1 |> Expect.equal True
        ]
        

setTest =
    describe "set"
        [ test "output is error when input is 0 and coreFixture1" <|
            \() ->
                set 0 coreFixture1 |> Expect.equal (Err "x must be > 1")
        , test "output is error when input is 10 and coreFixture1" <|
            \() ->
                set 10 coreFixture1 |> Expect.equal (Err "x must be < 9")
        , test "output is Core 1 when input is 1 and coreFixture1" <|
            \() ->
                set 1 coreFixture1 |> Expect.equal (Ok (Core (CoreCoin 1)))
        ]

        

killTest =
    describe "kill"
        [ test "output is coreFixture1 when input is coreFixture1" <|
            \() ->
                kill coreFixture1 |> Expect.equal coreFixture1
        , test "output is entryFixture1 when input is and entryFixture1" <|
            \() ->
                kill entryFixture1 |> Expect.equal entryFixture1
        , test "output is borderFixture2 when input is and borderFixture1" <|
            \() ->
                kill borderFixture1 |> Expect.equal borderFixture2
        ]


reviveTest =
    describe "revive"
        [ test "output is coreFixture1 when input is coreFixture1" <|
            \() ->
                revive coreFixture1 |> Expect.equal coreFixture1
        , test "output is entryFixture1 when input is and entryFixture1" <|
            \() ->
                revive entryFixture1 |> Expect.equal entryFixture1
        , test "output is borderFixture1 when input is and borderFixture2" <|
            \() ->
                revive borderFixture2 |> Expect.equal borderFixture1
        ]


hitTest =
    describe "hit"
        [ test "output is coreFixture1 when input is coreFixture1" <|
            \() ->
                hit coreFixture1 |> Expect.equal coreFixture1
        , test "output is entryFixture2 when input is entryFixture1" <|
            \() ->
                hit entryFixture1 |> Expect.equal entryFixture2
        , test "output is borderFixture1 when input is borderFixture1" <|
            \() ->
                hit borderFixture1 |> Expect.equal borderFixture1
        ]


unhitTest =
    describe "unhit"
        [ test "output is coreFixture1 when input is coreFixture1" <|
            \() ->
                unhit coreFixture1 |> Expect.equal coreFixture1
        , test "output is entryFixture2 when input is entryFixture1" <|
            \() ->
                unhit entryFixture2 |> Expect.equal entryFixture1
        , test "output is borderFixture3 when input is borderFixture2" <|
            \() ->
                unhit borderFixture2 |> Expect.equal borderFixture3
        ]


main =
    run <|
        describe "CoinModule"
            [ valueTest
            , aliveTest
            , counterTest
            , isHitTest
            , setTest
            , killTest
            , reviveTest
            , hitTest
            , unhitTest
            ]
