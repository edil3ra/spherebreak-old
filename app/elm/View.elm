module View exposing (view)

import Array
import Init exposing (Model, Msg)
import Info exposing (Difficulty(..))
import Html
import Html exposing (div, text)
import Html.Events exposing (onClick)
import Coins
import Coin
import Init exposing (Msg(..))


type alias GameInfo =
    { difficulty : String
    , currentPoint : String
    , currentTurn : String
    , currentTime : String
    , maxPoint : String
    , maxTurn : String
    , maxTime : String
    }


type alias ComboInfo =
    { sumValue : String
    , sumFactor : String
    , multipleValue : String
    , multipleFactor : String
    }


type alias CoinInfo =
    { value : String
    , clickMsg : Msg
    , x : Int
    , y : Int
    , width : Int
    , height : Int
    , fill : String
    }


type alias CoinsInfo =
    List CoinInfo


type alias BoardInfo =
    { width : Int
    , height : Int
    , coinsInfo : CoinsInfo
    }


toCoinInfo : Int -> Coin.Coin -> CoinInfo
toCoinInfo index coin =
    let
        value =
            Coin.value coin |> toString

        msg =
            Hit index coin

        fill =
            case coin of
                Coin.Core core ->
                    "red"

                Coin.Entry entry ->
                    "blue"

                Coin.Border border ->
                    "green"

        width =
            case coin of
                Coin.Core core ->
                    25

                Coin.Entry entry ->
                    50

                Coin.Border border ->
                    40

        height =
            case coin of
                Coin.Core core ->
                    25

                Coin.Entry entry ->
                    50

                Coin.Border border ->
                    40

        ( x, y ) =
            Array.get index coinPositions
    in
        CoinInfo value msg 0 0 width height


coinPositions -> Array.Array (Int, Int)
coinPosition =
    positions =
        Array.fromList
                [ ( 250, 250 )
                , ( 150, 150 )
                , ( 350, 150 )
                , ( 150, 350 )
                , ( 350, 350 )
                ]


toGameInfo : Model -> GameInfo
toGameInfo model =
    let
        difficulty =
            case model.info.difficulty of
                Easy ->
                    "easy"

                Medium ->
                    "medim"

                Hard ->
                    "hard"

        currentPoint =
            model.player.point |> toString

        currentTurn =
            model.info.currentTurn |> toString

        currentTime =
            model.info.currentTime |> toString

        maxPoint =
            model.info.maxPoint |> toString

        maxTurn =
            model.info.maxTurn |> toString

        maxTime =
            model.info.maxTime |> toString
    in
        GameInfo difficulty currentPoint currentTurn currentTime maxPoint maxTurn maxTime


toComboInfo : Model -> ComboInfo
toComboInfo model =
    let
        ( sumValue, sumFactor ) =
            model.player.comboSum

        ( multipleValue, multipleFactor ) =
            model.player.comboMultiple
    in
        ComboInfo (toString sumValue)
            (toString sumFactor)
            (toString multipleValue)
            (toString multipleFactor)


toBoardInfo : Model -> BoardInfo
toBoardInfo board =
    board


view : Model -> Html.Html Msg
view model =
    div
        []
        [ viewGameInfo (toGameInfo model)
        , viewComboInfo (toComboInfo model)
        , text (.value (Coins.core model.coins) |> toString)
        ]


viewGameInfo : GameInfo -> Html.Html Msg
viewGameInfo game =
    div
        []
        [ div [] [ text ("Difficulty: " ++ game.difficulty) ]
        , div [] [ text ("Time: " ++ game.currentTime ++ " / " ++ game.maxTime) ]
        , div [] [ text ("Turn: " ++ game.currentTurn ++ " / " ++ game.maxTurn) ]
        , div [] [ text ("Point: " ++ game.currentPoint ++ " / " ++ game.maxPoint) ]
        ]


viewComboInfo : ComboInfo -> Html.Html Msg
viewComboInfo combo =
    div
        []
        [ div [] [ text ("Multiple: " ++ combo.multipleValue ++ " - " ++ combo.multipleFactor) ]
        , div [] [ text ("Sum: " ++ combo.sumValue ++ " - " ++ combo.sumFactor) ]
        ]


viewCoin : CoinInfo -> Html.Html Msg
viewCoin coin =
    div
        [ onClick coin.clickMsg ]
        [ text coin.value ]
