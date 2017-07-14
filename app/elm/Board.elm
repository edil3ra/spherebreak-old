module Board exposing (..)

import Coin exposing (..)
import Array


board : Coins
board coins =
    Array.fromList
        [ Core CoreCoin 0
        , Entry EntryCoin 0
        , Entry EntryCoin 0
        , Entry EntryCoin 0
        , Entry EntryCoin 0
        , Border BorderCoin 0 False
        , Border BorderCoin 0 False
        , Border BorderCoin 0 False
        , Border BorderCoin 0 False
        , Border BorderCoin 0 False
        , Border BorderCoin 0 False
        , Border BorderCoin 0 False
        , Border BorderCoin 0 False
        , Border BorderCoin 0 False
        , Border BorderCoin 0 False
        ]
