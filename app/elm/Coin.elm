module Coin exposing (..)

min_value : Int
min_value =
    1


max_value : Int
max_value =
    9


min_counter : Int
min_counter =
    0


max_counter : Int
max_counter =
    8


type Coin
    = Core CoreCoin
    | Entry EntryCoin
    | Border BorderCoin


type alias CoreCoin =
    { value : Int }


type alias EntryCoin =
    { value : Int, alive : Bool }


type alias BorderCoin =
    { value : Int, alive : Bool, counter : Int }



value : Coin -> Int
value coin =
    case coin of
        Core core ->
            .value core
                
        Entry entry ->
            .value entry

        Border border ->
            .value border

        

alive : Coin -> Bool
alive coin =
    case coin of
        Core core ->
            True

        Entry entry ->
            .alive entry

        Border border ->
            .alive border


counter : Coin -> Maybe Int
counter coin =
    case coin of
        Core core ->
            Nothing

        Entry entry ->
            Nothing

        Border border ->
            .counter border |> Just


set : Int -> Coin -> Result String Coin
set x coin =
    if x < min_value then
        Err ("x must be > " ++ (min_value |> toString))
    else if x > max_value then
        Err ("x must be < " ++ (max_value |> toString))
    else
        case coin of
            Core core ->
                Ok (Core {core | value = x})

            Entry entry ->
                Ok (Entry {entry | value = x})

            Border border ->
                Ok (Border {border | value = x})

                

kill : Coin -> Coin
kill coin =
    case coin of
        Core core ->
            Core core

        Entry entry ->
            Entry { entry | alive = False }

        Border border ->
            Border { border | alive = False }


revive : Coin -> Coin
revive coin =
    case coin of
        Core core ->
            Core core

        Entry entry ->
            Entry { entry | alive = True }

        Border border ->
            Border { border | alive = True }


isMultiple : Int -> Coin -> Bool
isMultiple x coin =
    (value coin)
        |> rem x
        |> (==) 0
    
        

multipleFactor : Int -> Coin -> Int
multipleFactor x coin =
    x // (value coin)

        
