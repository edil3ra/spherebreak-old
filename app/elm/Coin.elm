module Coin exposing (..)

import Array


min_number =
    1

max_number =
    9

min_counter =
    0
              
max_counter =
    8

        
type Coin
    = Core CoreCoin
    | Entry EntryCoin
    | Border BorderCoin


type alias Coins =
    Array.Array Coin


type alias CoreCoin =
    { number : Int }


type alias EntryCoin =
    { number : Int, alive : Bool }


type alias BorderCoin =
    { number : Int, alive : Bool, counter: Int }


type alias EntriesCoin =
    Array.Array EntryCoin


type alias BordersCoin =
    Array.Array BorderCoin


type alias SumCoreCoin =
    ( Int, Int )


core : Coins -> CoreCoin
core coins =
    let
        fn coin =
            case coin of
                Core x ->
                    Just x

                Entry _ ->
                    Nothing

                Border _ ->
                    Nothing
    in
        coins
            |> Array.toList
            |> List.filterMap fn
            |> Array.fromList
            |> Array.get 0
            |> Maybe.withDefault (CoreCoin 1)


entries : Coins -> EntriesCoin
entries coins =
    let
        fn coin =
            case coin of
                Core _ ->
                    Nothing

                Entry x ->
                    Just x

                Border _ ->
                    Nothing
    in
        coins
            |> Array.toList
            |> List.filterMap fn
            |> Array.fromList


borders : Coins -> BordersCoin
borders coins =
    let
        fn coin =
            case coin of
                Core _ ->
                    Nothing

                Entry _ ->
                    Nothing

                Border x ->
                    Just x
    in
        coins
            |> Array.toList
            |> List.filterMap fn
            |> Array.fromList


sumCoins : Coins -> Int
sumCoins coins =
    let
        fnSumCoins fnFilter =
            coins
                |> fnFilter
                |> Array.filter .alive
                |> Array.map .number
                |> Array.toList
                |> List.sum
    in
        (fnSumCoins entries) + (fnSumCoins borders)


sumCore : Coins -> Int
sumCore coins =
    coins |> core |> .number


tupleSumCoinsSumCore : Coins -> SumCoreCoin
tupleSumCoinsSumCore coins =
    let
        entriesBorderSumNumber =
            sumCoins coins

        coreNumber =
            sumCore coins
    in
        ( entriesBorderSumNumber, coreNumber )


isMultiple : Coins -> Bool
isMultiple coins =
    let
        ( x, y ) =
            tupleSumCoinsSumCore coins
    in
        x % y == 0


isAliveMatch : Coins -> Int -> Bool
isAliveMatch coins number =
    let
        fnCountAlives fnFilter =
            coins
                |> fnFilter
                |> Array.filter .alive
                |> Array.length
    in
        (fnCountAlives entries) + (fnCountAlives borders) == number


multipleFactor : Coins -> Maybe Int
multipleFactor coins =
    let
        ( x, y ) =
            tupleSumCoinsSumCore coins

        factor =
            x // y

        isMultiple =
            x % y == 0
    in
        case isMultiple of
            True ->
                Just factor

            False ->
                Nothing


aliveBorders : Coins -> BordersCoin
aliveBorders coins =
    coins |> borders |> Array.filter .alive


deadBorders : Coins -> BordersCoin
deadBorders coins =
    coins |> borders |> Array.filter (\x -> not x.alive)


incrementBordersNumber : BordersCoin -> BordersCoin
incrementBordersNumber coins =
    coins |> Array.map (\coin -> { coin | number = coin.number + 1 })

        
incrementBordersCounter : BordersCoin -> BordersCoin
incrementBordersCounter coins =
    coins |> Array.map (\coin -> { coin | number = coin.counter + 1 })


resetBorderNumber : BordersCoin -> BordersCoin
resetBorderNumber coins =
    let
        fn coin =
            if coin.number <= max_number then
                coin
            else
                { coin | alive = False, number = min_number }
    in
        coins |> Array.map fn

            
resetBorderCounter : BordersCoin -> BordersCoin
resetBorderCounter coins =
    let
        fn coin =
            if coin.counter <= max_counter then
                coin
            else
                { coin | alive = False, counter = min_counter }
    in
        coins |> Array.map fn
            

nextTurn : Coins -> Coins
nextTurn coins =
    let
        coreCoin =
            core coins

        entriesCoin =
            entries coins |> Array.toList |> List.map (\x -> Entry x)

        bordersCoin =
            borders coins |> Array.toList

        bordersIncremented =
            bordersCoin
                |> List.map (\b -> { b | number = b.number + 1 })

        bordersFiltred =
            bordersIncremented
                |> List.map (\b -> { b | alive = b.number <= max_number })

        bordersNew =
            bordersFiltred
                |> List.map (\x -> Border x)
    in
        [ Core coreCoin ] ++ entriesCoin ++ bordersNew |> Array.fromList
