module Update exposing (..)

import Random
import Init exposing (Msg(..), Model, randomSeedCmd)
import Coin
import Info
import Coins
import Player
import Debug
import Tuple


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )

        Init seed ->
            ( handleInit seed model, Cmd.none )

        RecieveSeed seed ->
            ( handleSeed seed model, Cmd.none )

        Hit index coin ->
            ( handleHit index coin model, Cmd.none )

        Next ->
            ( handleNext model, randomSeedCmd )

        Reset ->
            ( handleReset model, Cmd.none )

        Tick _ ->
            ( handleTick model, Cmd.none )


handleSeed : Random.Seed -> Model -> Model
handleSeed newSeed model =
    { model | seed = newSeed }


handleInit : Random.Seed -> Model -> Model
handleInit newSeed model =
    { model | seed = newSeed } |> handleReset


handleHit : Int -> Coin.Coin -> Model -> Model
handleHit index coin model =
    if (Coin.isHit coin) then
        model
    else
        let
            newCoin =
                Coin.hit coin

            newCoins =
                Coins.set index newCoin model.coins

            newPlayer =
                Player.addHand (Coin.value coin) model.player

            goalReach =
                Player.isGoalReach newPlayer

            updatedModel =
                { model | coins = newCoins, player = newPlayer }
        in
            if (not goalReach) then
                updatedModel
            else
                updatedModel |> handleNext


handleNext : Model -> Model
handleNext model =
    let
        newSeed =3
            Random.step (Random.int 1 2) model.seed
                |> Tuple.second

        newCoins =
            Coins.next newSeed model.coins

        newCoreValue =
            newCoins
                |> Coins.core
                |> .value

                   

        newPlayer =
            Player.next newCoreValue model.player

        newInfo =
            Info.next model.info

        updatedModel =
            { model
                | player = newPlayer
                , coins = newCoins
                , info = newInfo
                , seed = newSeed
            }

        isWon =
            Info.isWon newPlayer.point newInfo

        isLost =
            Info.isLost newInfo
    in
        if isWon then
            handleWin updatedModel
        else if isLost then
            handleLost updatedModel
        else
            updatedModel


handleWin : Model -> Model
handleWin model =
    model |> handleReset


handleLost : Model -> Model
handleLost model =
    model |> handleReset


handleReset : Model -> Model
handleReset model =
    let
        updatedInfo =
            Info.reset model.info.difficulty

        updatedCoins =
            Coins.reset model.seed model.coins

        coreValue =
            updatedCoins
                |> Coins.core
                |> .value

        updatedPlayer =
            Player.reset coreValue model.player
    in
        { model
            | info = updatedInfo
            , coins = updatedCoins
            , player = updatedPlayer
        }


handleTick : Model -> Model
handleTick model =
    let
        newInfo =
            Info.tick model.info

        timeOver =
            Info.isTimeOver newInfo

        updatedModel =
            { model | info = newInfo }
    in
        if (not timeOver) then
            updatedModel
        else
            updatedModel |> handleNext
