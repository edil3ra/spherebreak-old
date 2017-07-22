module View exposing (view)

import Array
import Init exposing (Model, Msg)
import Info exposing (Difficulty(..))
import Html
import Html.Attributes
import Html exposing (div, text, h2, select, option, button)
import Html.Events
import Svg
import Svg.Attributes
import Svg.Events
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


type alias ActionInfo =
    { options : List String  
    , buttonMsg : Msg
    }


type alias CoinInfo =
    { value : String
    , clickMsg : Msg
    , x : Int
    , y : Int
    , size : Int
    , fill : String
    , fillOpacity : Float
    }


type alias CoinsInfo =
    List CoinInfo


type alias BoardInfo =
    { width : Int
    , height : Int
    , fill : String
    , coinsInfo : CoinsInfo
    }


coinPositions : Array.Array ( Int, Int )
coinPositions =
    let
        cores =
            [ ( 250, 250 ) ]

        entries =
            [ ( 185, 185 )
            , ( 315, 185 )
            , ( 185, 315 )
            , ( 315, 315 )
            ]

        borders =
            [ ( 63, 63 )
            , ( 188, 63 )
            , ( 313, 63 )
            , ( 438, 63 )
            , ( 438, 188 )
            , ( 438, 313 )
            , ( 438, 438 )
            , ( 313, 438 )
            , ( 188, 438 )
            , ( 63, 438 )
            , ( 63, 313 )
            , ( 63, 188 )
            ]
    in
        Array.fromList (cores ++ entries ++ borders)


toGameInfo : Model -> GameInfo
toGameInfo model =
    let
        difficulty =
            case model.info.difficulty of
                Easy ->
                    "Easy"

                Medium ->
                    "Medium"

                Hard ->
                    "Hard"

                Brutal ->
                    "Brutal"

                Insane ->
                    "Insane"

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


toActionInfo : Model -> ActionInfo
toActionInfo model =
    let
        options =
            [ "Easy" 
            , "Medium"
            , "Hard"
            , "Brutal"
            , "Insane"
            ]

                
        buttonMsg =
            Play
                
    in
        ActionInfo options buttonMsg


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

        size =
            case coin of
                Coin.Core core ->
                    30

                Coin.Entry entry ->
                    50

                Coin.Border border ->
                    40

        fillOpacity =
            if not (Coin.isHit coin) then
                1
            else
                0.4

        ( x, y ) =
            Array.get index coinPositions |> Maybe.withDefault ( 0, 0 )
    in
        CoinInfo value msg x y size fill fillOpacity


toBoardInfo : Model -> BoardInfo
toBoardInfo model =
    let
        width =
            500

        height =
            500

        fill =
            "#f8f8f8"

        coinsInfo =
            (Coins.withIndexes model.coins)
                |> List.filter (\( index, coin ) -> Coin.alive coin)
                |> List.map (\( index, coin ) -> toCoinInfo index coin)
    in
        BoardInfo width height fill coinsInfo


view : Model -> Html.Html Msg
view model =
    div
        [ Html.Attributes.class "game" ]
        [ div
            [ Html.Attributes.class "panel-left" ]
            [ viewGameInfo (toGameInfo model)
            , viewComboInfo (toComboInfo model)
            , viewActionsInfo (toActionInfo model)
            ]
        , div [ Html.Attributes.class "board" ]
            [ viewBoardInfo (toBoardInfo model) ]
        ]


viewGameInfo : GameInfo -> Html.Html Msg
viewGameInfo game =
    div
        [ Html.Attributes.class "info" ]
        [ h2 [] [ text "Info" ]
        , div [] [ text ("Difficulty: " ++ game.difficulty) ]
        , div [] [ text ("Time: " ++ game.currentTime ++ " / " ++ game.maxTime) ]
        , div [] [ text ("Turn: " ++ game.currentTurn ++ " / " ++ game.maxTurn) ]
        , div [] [ text ("Point: " ++ game.currentPoint ++ " / " ++ game.maxPoint) ]
        ]


viewComboInfo : ComboInfo -> Html.Html Msg
viewComboInfo combo =
    div
        [ Html.Attributes.class "combo" ]
        [ h2 [] [ text "Combo" ]
        , div [] [ text ("Multiple: " ++ combo.multipleValue ++ " - " ++ combo.multipleFactor) ]
        , div [] [ text ("Sum: " ++ combo.sumValue ++ " - " ++ combo.sumFactor) ]
        ]


-- viewActionsInfo : ActionInfo -> Html.Html Msg
-- viewActionsInfo actions =
--     div
--         [ Html.Attributes.class "actions" ]
--         [ h2 [] [ text "Actions" ]
--         , div []
--             [ select [ Html.Attributes.class "btn" ]
--                 [ option
--                     []
--                     [ text "Easy" ]
--                 , option
--                     []
--                     [ text "Medium" ]
--                 , option
--                     []
--                     [ text "Hard" ]
--                 , option
--                     []
--                     [ text "Brutal" ]
--                 , option
--                     []
--                     [ text "Insane" ]
--                 ]
--             , div []
--                 [ button
--                     [ Html.Attributes.class "btn"
--                     , Html.Events.onClick actions.playMsg
--                     ]
--                     [ text "Play" ]
--                 ]
--             ]
--         ]

textToDiffuclty : String -> Msg
textToDiffuclty string =
    case string of
        "Easy" ->
            ChangeDifficulty Easy
                
        "Medium" ->
            ChangeDifficulty Medium
                
        "Hard" ->
            ChangeDifficulty Hard
                
        "Brutal" ->
            ChangeDifficulty Brutal
                
        "Insane" ->
            ChangeDifficulty Insane
                
        _ ->
            ChangeDifficulty Easy
                
        
    

viewActionsInfo : ActionInfo -> Html.Html Msg
viewActionsInfo actions =
    div
        [ Html.Attributes.class "actions" ]
        [ h2 [] [ text "Actions" ]
        , div []
            [ select
                  [ Html.Attributes.class "btn"
                  , Html.Events.onInput textToDiffuclty
                  ] 
                  (actions.options
                  |> List.map (\s -> option [Html.Attributes.value s] [text s ]))
            , div []
                [ -- button
                  --   [ Html.Attributes.class "btn"
                  --   , Html.Events.onClick actions.buttonMsg
                  --   ]
                  --   [ text "Play" ]
                ]
            ]
        ]
        


viewBoardInfo : BoardInfo -> Html.Html Msg
viewBoardInfo board =
    let
        width =
            board.width |> toString

        height =
            board.height |> toString

        fill =
            board.fill

        coinsInfoCsv =
            List.map viewCoinInfo board.coinsInfo
    in
        Svg.svg
            [ Svg.Attributes.width width
            , Svg.Attributes.height height
            ]
            [ Svg.rect
                [ Svg.Attributes.width width
                , Svg.Attributes.height height
                , Svg.Attributes.fill fill
                ]
                []
            , Svg.g [] coinsInfoCsv
            ]


viewCoinInfo : CoinInfo -> Svg.Svg Msg
viewCoinInfo coin =
    let
        x =
            coin.x |> toString

        y =
            coin.y |> toString

        size =
            coin.size |> toString

        fill =
            coin.fill

        fillOpacity =
            coin.fillOpacity |> toString

        msg =
            coin.clickMsg

        value =
            coin.value
    in
        Svg.g
            [ Svg.Events.onClick msg
            , Svg.Attributes.cursor "pointer"
            ]
            [ Svg.circle
                [ Svg.Attributes.r size
                , Svg.Attributes.cx x
                , Svg.Attributes.cy y
                , Svg.Attributes.fill fill
                , Svg.Attributes.fillOpacity fillOpacity
                ]
                []
            , Svg.text_
                [ Svg.Attributes.x x
                , Svg.Attributes.y y
                , Svg.Attributes.dy "7"
                , Svg.Attributes.textAnchor "middle"
                , Svg.Attributes.fontSize "25px"
                , Svg.Attributes.fill "white"
                ]
                [ Svg.text value ]
            ]
