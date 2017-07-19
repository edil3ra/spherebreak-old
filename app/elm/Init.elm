module Init exposing (..)

import Coins
import Coin
import Player
import Info


type alias Model =
    { player: Player.Player
    , coins: Coins.Coins
    , info: Info.Info
    }

coins : Coins.Coins
coins =
    [ Coin.Core (Coin.CoreCoin 0)
    , Coin.Entry (Coin.EntryCoin 0 False)
    , Coin.Entry (Coin.EntryCoin 0 False)
    , Coin.Entry (Coin.EntryCoin 0 False)
    , Coin.Entry (Coin.EntryCoin 0 False)
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    ]



player: Player.Player
player = Player.Player [] 0 0 (0, 0) (0, 0) 
    

info: Info.Info
info Info.reset Info.Easy
         
    
model: Model
model = Model player coins info
