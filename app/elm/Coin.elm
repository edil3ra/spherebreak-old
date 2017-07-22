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
    4


type Coin
    = Core CoreCoin
    | Entry EntryCoin
    | Border BorderCoin


type alias CoreCoin =
    { value : Int }


type alias EntryCoin =
    { value : Int, hitted : Bool }


type alias BorderCoin =
    { value : Int, hitted : Bool, alive : Bool, counter : Int }


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
            True

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


isHit : Coin -> Bool
isHit coin =
    case coin of
        Core core ->
            False

        Entry entry ->
            .hitted entry

        Border border ->
            .hitted border


set : Int -> Coin -> Result String Coin
set x coin =
    if x < min_value then
        Err ("x must be > " ++ (min_value |> toString))
    else if x > max_value then
        Err ("x must be < " ++ (max_value |> toString))
    else
        case coin of
            Core core ->
                Ok (Core { core | value = x })

            Entry entry ->
                Ok (Entry { entry | value = x })

            Border border ->
                Ok (Border { border | value = x })


kill : Coin -> Coin
kill coin =
    case coin of
        Core core ->
            Core core

        Entry entry ->
            Entry entry

        Border border ->
            Border { border | alive = False }


revive : Coin -> Coin
revive coin =
    case coin of
        Core core ->
            Core core

        Entry entry ->
            Entry entry

        Border border ->
            Border { border | alive = True }


hit : Coin -> Coin
hit coin =
    case coin of
        Core core ->
            Core core

        Entry entry ->
            Entry { entry | hitted = True }

        Border border ->
            Border { border | hitted = True }


unhit : Coin -> Coin
unhit coin =
    case coin of
        Core core ->
            Core core

        Entry entry ->
            Entry { entry | hitted = False }

        Border border ->
            Border { border | hitted = False }


isEmpty : Coin -> Bool
isEmpty coin =
    case coin of
        Core core ->
            True

        Entry entry ->
            entry.hitted

        Border border ->
            border.hitted || (not border.alive)
                
                
reset: Int -> Coin -> Coin
reset value coin =
    case coin of
        Core core ->
            Core core
                |> set value
                |> Result.withDefault coin
                
        Entry entry ->
            Entry entry
                |> unhit

        Border border ->
            border
                |> (\border -> { border | counter = min_counter })
                |> Border
                |> set value
                |> Result.withDefault coin
                |> unhit
                |> revive

    
                
next : Int -> Coin -> Coin
next value coin =
    case coin of
        Core core ->
            Core core
                |> set value
                |> Result.withDefault coin

        Entry entry ->
            Entry entry
                |> unhit

        Border border ->
            let
                isDead =
                    not border.alive
                        
                isCounterOver =
                    border.counter + 1 >= max_counter

                isToBig =
                    border.value + 1 > max_value

                isHit =
                    border.hitted

                resetCounter =
                    (\border -> { border | counter = min_counter })

                incCounter =
                    (\border -> { border | counter = border.counter + 1 })

                incValue =
                    (\border -> { border | value = border.value + 1 })
            in
                if isDead then
                    if isCounterOver then
                        border
                            |> resetCounter
                            |> Border
                            |> unhit
                            |> revive
                            |> set value
                            |> Result.withDefault coin
                    else
                        border
                            |> incCounter
                            |> Border
                else
                    if isToBig || isHit then
                        border
                            |> Border
                            |> unhit
                            |> kill
                    else
                        border
                            |> incValue
                            |> Border

                           
