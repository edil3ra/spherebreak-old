module Update exposing (..)

import Random
import Init exposing (Msg(..), Model, randomSeedCmd)
import Coin
import Info
import Coins
import Player
import Debug


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg |> Debug.log "msg: " of
        Noop ->
            ( model, Cmd.none )

        RecieveSeed seed ->
            ( handleSeed seed model, Cmd.none )

        Hit index coin ->
            ( handleHit index coin model, Cmd.none )

        Next ->
            ( handleNext model, randomSeedCmd )

        Reset ->
            ( model, Cmd.none )

        Tick _ ->
            ( handleTick model, Cmd.none )


handleSeed : Random.Seed -> Model -> Model
handleSeed newSeed model =
    { model | seed = newSeed }


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
        seed =
            model.seed

        newCoins =
            Coins.next seed model.coins

        coreValue =
            newCoins
                |> Coins.core
                |> .value

        newPlayer =
            Player.next coreValue model.player

        newInfo =
            Info.next model.info

        updatedModel =
            { model
                | player = newPlayer
                , coins = newCoins
                , info = newInfo
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
            {model | info = newInfo}
    in
        if (not timeOver) then
            updatedModel 
        else
            updatedModel |> handleNext
