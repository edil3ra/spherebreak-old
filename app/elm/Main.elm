module Main exposing (..)


{-| This library fills a bunch of important niches in Elm. A `Maybe` can help
you with optional arguments, error handling, and records with optional fields.
-}


import Html
import Html exposing (div, text, program)


type alias Model = {
    hello: String
}

type Msg = Noop
        
    


init: (Model, Cmd Msg)
init = ( Model "hello" , Cmd.none)


    
    
subscriptions: Model -> Sub Msg
subscriptions model =
    Sub.none

                
                
update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Noop -> (model, Cmd.none)
        



              

view : Model -> Html.Html Msg
view model =
    div
    [] [
     text "hello"
    ]
        

    
main : Program Never Model Msg
main =
    program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }
