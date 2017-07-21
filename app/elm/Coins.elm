module Coins exposing (..)

import Array
import Tuple
import Coin
import Coin exposing (Coin(..), CoreCoin, EntryCoin, BorderCoin, min_value, max_value)
import Random


type alias EntriesCoin =
    List EntryCoin


type alias BordersCoin =
    List BorderCoin


type alias Coins =
    List Coin


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
            |> List.filterMap fn
            |> List.head
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
            |> List.filterMap fn


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
            |> List.filterMap fn


get : Int -> Coins -> Maybe Coin
get index coins =
    Array.fromList coins
        |> Array.get index


set : Int -> Coin -> Coins -> Coins
set index coin coins =
    Array.fromList coins
        |> Array.set index coin
        |> Array.toList


withIndexes : Coins -> List (Int, Coin)
withIndexes coins =
    let
        indexes =
            List.range 0 (List.length coins)
    in
        List.map2 (\index coin -> (index, coin)) indexes coins


reset : Random.Seed -> Coins -> Coins
reset seed coins =
    let
        newValuesGen : Random.Generator (List Int)
        newValuesGen =
            Random.list ((List.length coins) + 1) (Random.int min_value max_value)

        newValues : List Int
        newValues =
            (Random.step newValuesGen seed) |> Tuple.first |> List.drop 1
    in
        List.map2 (\coin value -> Coin.reset value coin) coins newValues


next : Random.Seed -> Coins -> Coins
next seed coins =
    let
        newValuesGen : Random.Generator (List Int)
        newValuesGen =
            Random.list ((List.length coins) + 1) (Random.int min_value max_value)

        newValues : List Int
        newValues =
            (Random.step newValuesGen seed) |> Tuple.first |> List.drop 1
    in
        List.map2 (\coin value -> Coin.next value coin) coins newValues
