module View exposing (view)

import Init exposing (Model, Msg)
import Info exposing (Difficulty(..))
import Html
import Html exposing (div, text)


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


toGameInfo : Model -> GameInfo
toGameInfo model =
    let
        difficulty =
            case model.info.difficulty of
                Easy ->
                    "easy"

                Medium ->
                    "medim"

                hard ->
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


view : Model -> Html.Html Msg
view model =
    div
        []
        [ viewGameInfo (toGameInfo model)
        , viewComboInfo (toComboInfo model)
        ]


viewGameInfo : GameInfo -> Html.Html Msg
viewGameInfo game =
    div
        []
          [ div [] [text ("Difficulty: " ++  game.difficulty)]
          , div [] [text ("Time: " ++  game.currentTime ++ " / " ++ game.maxTime)]
          , div [] [text ("Turn: " ++  game.currentTurn ++ " / " ++ game.maxTurn)]
          , div [] [text ("Point: " ++  game.currentPoint ++ " / " ++ game.maxPoint)]
        ]


viewComboInfo : ComboInfo -> Html.Html Msg
viewComboInfo combo =
    div
        []
          [ div [] [text ("Multiple: " ++  combo.multipleValue ++ " - " ++ combo.multipleFactor)]
          , div [] [text ("Sum: " ++  combo.sumValue ++ " - " ++ combo.sumFactor)]
        ]
