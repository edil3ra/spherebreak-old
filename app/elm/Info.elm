module Info exposing (..)


type Difficulty
    = Easy
    | Medium
    | Hard
    | Brutal
    | Insane


type alias Info =
    { difficulty : Difficulty
    , maxPoint : Int
    , currentTurn : Int
    , maxTurn : Int
    , currentTime : Int
    , maxTime : Int
    }


reset : Difficulty -> Info
reset difficulty =
    case difficulty of
        Easy ->
            Info Easy 100 0 30 0 60

        Medium ->
            Info Medium 200 0 30 0 30

        Hard ->
            Info Hard 300 0 20 0 15

        Brutal ->
            Info Brutal 300 0 20 0 10

        Insane ->
            Info Insane 500 0 30 0 8


tick : Info -> Info
tick info =
    { info | currentTime = info.currentTime + 1 }

        
isTimeOver: Info -> Bool
isTimeOver info =
    info.currentTime >= info.maxTime
        

next : Info -> Info
next info =
    { info
        | currentTime = 0
        , currentTurn = info.currentTurn + 1
    }
    
    
isWon : Int -> Info -> Bool
isWon point info =
    point >= info.maxPoint



isLost :  Info -> Bool
isLost info =
    info.currentTurn > info.maxTurn 
