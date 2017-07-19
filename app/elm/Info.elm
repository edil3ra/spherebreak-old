module Info exposing (..)


type Difficulty
    = Easy
    | Medium
    | Hard


type alias Info =
    { difficutly : Difficulty
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


tick : Info -> Info
tick info =
    { info | currentTime = info.currentTime + 1 }


next : Info -> Info
next info =
    { info
        | currentTime = 0
        , currentTurn = info.currentTurn + 1
    }


isWon : Int -> Info -> Bool
isWon goal info =
    goal >= info.maxPoint



isLost :  Info -> Bool
isLost info =
    info.currentTurn > info.maxTurn 
