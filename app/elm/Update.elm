module Update exposing (..)

import Debug
import Random
import Init exposing (Msg(..), Model, randomSeedCmd)
import Coin
import Info
import Coins
import Player
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

        Play ->
            ( handlePlay model, Cmd.none )

        ChangeDifficulty difficulty ->
            ( handleDifficulty difficulty model, Cmd.none )

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
    if (Coin.isHit coin) || (Coin.isCore coin) then
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

            isEmpty =
                List.all (\coin -> Coin.isEmpty coin) newCoins

            updatedModel =
                { model | coins = newCoins, player = newPlayer }
        in
            if isEmpty then
                updatedModel |> handleNext
            else if (not goalReach) then
                updatedModel
            else
                updatedModel |> handleNext


handleNext : Model -> Model
handleNext model =
    let
        newSeed =
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


handleDifficulty : Info.Difficulty -> Model -> Model
handleDifficulty difficulty model =
    let
        oldInfo =
            model.info

        newInfo =
            { oldInfo | difficulty = difficulty }
    in
        { model | info = newInfo } |> handlePlay


handlePlay : Model -> Model
handlePlay model =
    let
        newInfo =
            Info.reset model.info.difficulty

        resetModel =
            handleReset model
    in
        { resetModel | info = newInfo }
