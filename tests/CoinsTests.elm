module CoinTests exposing (main)

import Test exposing (describe, test)
import Expect
import Test.Runner.Html exposing (run)
import Coins exposing (..)
import Coin
import Coin exposing (Coin(..), CoreCoin, EntryCoin, BorderCoin)
import Random


coinCore1 =
    (CoreCoin 4)


coinEntry1 =
    (EntryCoin 1 True)


coinEntry2 =
    (EntryCoin 2 False)


coinBorder1 =
    (BorderCoin 2 True True Coin.min_counter)


coinBorder2 =
    (BorderCoin 1 False False Coin.max_counter)


coinBorder3 =
    (BorderCoin 3 True True Coin.min_counter)


coinBorder4 =
    (BorderCoin 4 False True Coin.min_counter)


coinBorder5 =
    (BorderCoin 5 False True Coin.min_counter)


coinsFixture1 : Coins
coinsFixture1 =
    [ Core coinCore1
    , Entry coinEntry1
    , Entry coinEntry2
    , Border coinBorder1
    , Border coinBorder2
    , Border coinBorder3
    , Border coinBorder4
    ]


coinsFixture2 : Coins
coinsFixture2 =
    [ Core coinCore1
    , Entry coinEntry1
    , Entry coinEntry2
    , Border coinBorder1
    , Border coinBorder2
    , Border coinBorder3
    , Border coinBorder5
    ]


coreTest =
    describe "coins"
        [ test "output is coinCore1 when input is coinsFixture1" <|
            \() ->
                core coinsFixture1 |> Expect.equal coinCore1
        ]


entriesTest =
    describe "entries"
        [ test "output is List coinEntry1 coinEntry2 when input is coinsFixture1" <|
            \() ->
                entries coinsFixture1 |> Expect.equal [ coinEntry1, coinEntry2 ]
        ]


bordersTest =
    describe "borders"
        [ test "output is List borderEntry1 borderEntry2 borderEntry3 borderEntry4 when input is coinsFixture1" <|
            \() ->
                borders coinsFixture1 |> Expect.equal [ coinBorder1, coinBorder2, coinBorder3, coinBorder4 ]
        ]


getTest =
    describe "get"
        [ test "output is Maybe coinEntry1 when input is 1 and coinsFixture1" <|
            \() ->
                get 1 coinsFixture1 |> Expect.equal (Just (Entry coinEntry1))
        ]


setTest =
    describe "set"
        [ test "output is coinsFixture2 when input is 7 and coinFixture5 and coinsFixture1" <|
            \() ->
                set 6 (Border coinBorder5) coinsFixture1 |> Expect.equal coinsFixture2
        ]


nextTest =
    describe "next"
        [ let
            coinsFixtureInput =
                [ Core (CoreCoin 1)
                , Entry (EntryCoin 1 False)
                , Border (BorderCoin 1 False False Coin.max_counter)
                , Border (BorderCoin 1 False False 0)
                , Border (BorderCoin 1 True True 0)
                , Border (BorderCoin 1 False True 0)
                ]

            coinsFixtureResult =
                [ Core (CoreCoin 3)
                , Entry (EntryCoin 1 False)
                , Border (BorderCoin 2 False True Coin.min_counter)
                , Border (BorderCoin 1 False False 1)
                , Border (BorderCoin 1 False False 0)
                , Border (BorderCoin 2 False True 0)
                ]
          in
            test "output is coinsFixtureResult when input is coinsFixtureInput" <|
                \() ->
                    next (Random.initialSeed 1) coinsFixtureInput |> Expect.equal coinsFixtureResult
        ]


main =
    run <|
        describe "CoinModule"
            [ coreTest
            , entriesTest
            , bordersTest
            , getTest
            , setTest
            , nextTest
            ]
