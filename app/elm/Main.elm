module Main exposing (..)
import View exposing (view)
import Init exposing (Model, Msg, init, subscriptions)
import Update exposing (update)
import Html exposing (program)
        

    
main : Program Never Model Msg
main =
    program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

