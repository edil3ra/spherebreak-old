module CoinTests exposing (main)

import Test exposing (describe, test)
import Expect
import Test.Runner.Html exposing (run)
import Coin exposing (..)
import Array
import Debug


coinCore1 =
    (CoreCoin 4)


coinEntry1 =
    (EntryCoin 1 True)


coinEntry2 =
    (EntryCoin 2 True)


coinEntry3 =
    (EntryCoin 3 True)


coinEntry4 =
    (EntryCoin 4 True)


coinBorder1 =
    (BorderCoin 1 True min_counter)


coinBorder2 =
    (BorderCoin 2 True min_counter)


coinBorder3 =
    (BorderCoin 3 True min_counter)


coinBorder4 =
    (BorderCoin 4 True min_counter)


coinBorder5 =
    (BorderCoin 5 True min_counter)


coinBorder6 =
    (BorderCoin 6 True min_counter)


coinBorder7 =
    (BorderCoin 7 True min_counter)


coinBorder8 =
    (BorderCoin 8 True min_counter)


coinBorder9 =
    (BorderCoin 9 True min_counter)


coinBorder10 =
    (BorderCoin 1 True min_counter)


coinBorder11 =
    (BorderCoin 0 False max_counter)


coinBorder12 =
    (BorderCoin 9 False max_counter)


coinsFixture : Coins
coinsFixture =
    Array.fromList
        [ Core coinCore1
        , Entry coinEntry1
        , Entry coinEntry2
        , Entry coinEntry3
        , Entry coinEntry4
        , Border coinBorder1
        , Border coinBorder2
        , Border coinBorder3
        , Border coinBorder4
        , Border coinBorder5
        , Border coinBorder6
        , Border coinBorder7
        , Border coinBorder8
        , Border coinBorder9
        , Border coinBorder10
        , Border coinBorder11
        , Border coinBorder12
        ]


coinsFixture2 : Coins
coinsFixture2 =
    Array.fromList
        [ Core coinCore1
        , Entry coinEntry1
        , Entry coinEntry2
        , Entry coinEntry3
        , Entry coinEntry4
        , Border coinBorder1
        , Border coinBorder2
        , Border coinBorder3
        , Border coinBorder3
        , Border coinBorder11
        ]


coinsFixture3 : Coins
coinsFixture3 =
    Array.fromList
        [ Core coinCore1
        , Entry coinEntry1
        , Entry coinEntry2
        , Entry coinEntry3
        , Entry coinEntry4
        , Border coinBorder2
        , Border coinBorder3
        , Border coinBorder4
        , Border coinBorder4
        , Border coinBorder11
        ]


coreTest =
    describe "coins"
        [ test "output is coinCore1 when input is coinsFixture" <|
            \() ->
                core coinsFixture |> Expect.equal coinCore1
        ]


entriesTest =
    describe "entries"
        [ test "output is [coinEntry1, coinEntry2, coinEntry3, coinEntry4] when input is coinsFixture" <|
            \() ->
                let
                    entriesCoin =
                        Array.fromList [ coinEntry1, coinEntry2, coinEntry3, coinEntry4 ]
                in
                    entries coinsFixture |> Expect.equal entriesCoin
        ]


bordersTest =
    describe "entries"
        [ test "output is [coinEntry1, coinEntry2, coinEntry3, coinEntry4, coinEntry5, coinEntry6, coinEntry7, coinEntry8, coinEntry9, coinEntry10, coinEntry11, coinEntry12] when input is coinsFixture" <|
            \() ->
                let
                    bordersCoin =
                        Array.fromList [ coinBorder1, coinBorder2, coinBorder3, coinBorder4, coinBorder5, coinBorder6, coinBorder7, coinBorder8, coinBorder9, coinBorder10, coinBorder11, coinBorder12 ]
                in
                    borders coinsFixture |> Expect.equal bordersCoin
        ]


sumCoinsTest =
    describe "sumCoins"
        [ test "output is 56  when input is coinsFixture" <|
            \() ->
                sumCoins coinsFixture |> Expect.equal 56
        ]


sumCoreTest =
    describe "sumCore"
        [ test "output is 4  when input is coinsFixture" <|
            \() ->
                sumCore coinsFixture |> Expect.equal 4
        ]


tupleSumCoinsSumCoreTest =
    describe "tupleSumCoinsSumCore"
        [ test "output is (56, 4)  when input is coinsFixture" <|
            \() ->
                tupleSumCoinsSumCore coinsFixture |> Expect.equal ( 56, 4 )
        ]


isMultipleTest =
    describe "isMultiple"
        [ test "output is True  when input is coinsFixture" <|
            \() ->
                isMultiple coinsFixture |> Expect.equal True
        , test "output False when input is coinsFixture2" <|
            \() ->
                isMultiple coinsFixture2 |> Expect.equal False
        ]


isAliveMatchTest =
    describe "isAliveMatch"
        [ test "output is True  when input is coinsFixture and 10" <|
            \() ->
                isAliveMatch coinsFixture 14 |> Expect.equal True
        , test "output is True  when input is coinsFixture and 1" <|
            \() ->
                isAliveMatch coinsFixture 1 |> Expect.equal False
        ]


multipleFactorTest =
    describe "multipleFactorTest"
        [ test "output is Just 14 when input is coinsFixture" <|
            \() ->
                multipleFactor coinsFixture |> Expect.equal (Just 14)
        , test "output in Nothing when input is coinsFixture2" <|
            \() ->
                multipleFactor coinsFixture2 |> Expect.equal Nothing
        ]



aliveBordersTest =
    describe "aliveBorders"
        [ test "output is BorderCoins [coinBorder1, coinBorder2, coinBorder3, coinBorder3] when input is coinFixture2" <|
            \() ->
                 aliveBorders coinsFixture2 |> Expect.equal (Array.fromList [ coinBorder1, coinBorder2, coinBorder3, coinBorder3 ])
        ]

        
deadBordersTest =
    describe "deadBorders"
        [ test "output is BorderCoins [coinBorder11] when input is coinFixture2" <|
            \() ->
                 deadBorders coinsFixture2 |> Expect.equal (Array.fromList [ coinBorder11 ])
        ]


incrementBordersNumber =
    describe "incrementBordersNumber"
        [ test "output is "]
        
        
nextTurnTest =
    describe "nextTurnTest"
        [ test "output is coinsFixture3 when input is coinFixture2" <|
            \() ->
                nextTurn coinsFixture2 |> Expect.equal coinsFixture3
        ]

        
main =
    run <|
        describe "CoinModule"
            [ coreTest
            , entriesTest
            , bordersTest
            , sumCoinsTest
            , sumCoreTest
            , tupleSumCoinsSumCoreTest
            , isMultipleTest
            , isAliveMatchTest
            , multipleFactorTest
            , deadBordersTest
            , aliveBordersTest
            -- , nextTurnTest
            ]
