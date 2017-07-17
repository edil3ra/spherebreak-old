module Coins exposing (..)

import Array
import Coin
import Coin exposing (Coin(..), CoreCoin, EntryCoin, BorderCoin)


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


set : Int ->  Coin -> Coins -> Coins
set index coin coins =
      Array.fromList coins
          |> Array.set index coin
          |> Array.toList
      
      
