module Init exposing (..)

import Coins
import Coin
import Player
import Info
import Random
import Time

type alias Model =
    { player : Player.Player
    , coins : Coins.Coins
    , info : Info.Info
    , seed: Random.Seed
    }


type Msg
    = Noop
    | RecieveSeed Random.Seed
    | Init Random.Seed
    | Hit Int Coin.Coin
    | Next
    | Reset
    | Tick Time.Time


initCoins : Coins.Coins
initCoins =
    [ Coin.Core (Coin.CoreCoin 0)
    , Coin.Entry (Coin.EntryCoin 1 False)
    , Coin.Entry (Coin.EntryCoin 2 False)
    , Coin.Entry (Coin.EntryCoin 3 False)
    , Coin.Entry (Coin.EntryCoin 4 False)
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
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    , Coin.Border (Coin.BorderCoin 0 False True 0)
    ]


initPlayer : Player.Player
initPlayer =
    Player.Player [] 0 0 ( 0, 0 ) ( 0, 0 )


initInfo : Info.Info
initInfo =
    Info.reset Info.Hard


initModel : Model
initModel =
    Model initPlayer initCoins initInfo (Random.initialSeed 0)


subscriptions: Model -> Sub Msg
subscriptions model =
    Time.every Time.second Tick


initSeedCmd: Cmd Msg
initSeedCmd =
    Random.generate
        (\value ->  Random.initialSeed value |> Init)
        (Random.int 2 1000)

randomSeedCmd: Cmd Msg
randomSeedCmd =
    Random.generate
        (\value ->  Random.initialSeed value |> Init)
        (Random.int 10 1000)
        


            
init: (Model, Cmd Msg)
init = (initModel, initSeedCmd)


