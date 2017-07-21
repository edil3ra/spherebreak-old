module Player exposing (..)


type alias ComboLength =
    Int


type alias ComboCount =
    Int


type alias Combo =
    ( ComboLength, ComboCount )


type alias Hand =
    List Int


type alias Player =
    { hand : Hand
    , goal : Int
    , point : Int
    , comboSum : Combo
    , comboMultiple : Combo
    }


addHand : Int -> Player -> Player
addHand value player =
    { player | hand = value :: player.hand }


resetHand : Player -> Player
resetHand player =
    { player | hand = [] }


countHand : Player -> Int
countHand player =
    player.hand |> List.length


sumHand : Player -> Int
sumHand player =
    player.hand |> List.sum


factor : Player -> Int
factor player =
    (sumHand player) // player.goal


rem : Player -> Int
rem player =
    (sumHand player) % player.goal


isGoalReach : Player -> Bool
isGoalReach player =
    (factor player) > 0 && (rem player) == 0


updateCombo : Player -> Player
updateCombo player =
    let
        multipleLength1 =
            factor player

        sumLength1 =
            countHand player

        ( multipleLength2, multipleCount ) =
            player.comboMultiple

        ( sumLength2, sumCount ) =
            player.comboSum

        updatedMultiple =
            if multipleLength1 == multipleLength2 then
                ( multipleLength1, multipleCount + 1 )
            else
                ( multipleLength1, 0 )

        updatedSum =
            if sumLength1 == sumLength2 then
                ( sumLength1, sumCount + 1 )
            else
                ( sumLength1, 0 )
    in
        { player | comboMultiple = updatedMultiple, comboSum = updatedSum }


calculateCombo : Player -> Int
calculateCombo player =
    let
        ( multipleLength, multipleCount ) =
            player.comboMultiple

        ( sumLength, sumCount ) =
            player.comboSum

        multiple =
            if multipleLength == 0 then
                0
            else
                multipleLength ^ multipleCount

        sum =
            sumLength * sumCount
    in
        multiple + sum

resetCombo : Player -> Player
resetCombo player =
    {player | comboSum = (0, 0), comboMultiple = (0, 0)}
             


updatePoint : Player -> Player
updatePoint player =
    { player | point = player.point + (sumHand player) + (calculateCombo player) }


next : Int -> Player -> Player
next newGoal player =
    if (isGoalReach player) then
        player
            |> updatePoint
            |> \player -> { player | goal = newGoal }
            |> resetHand
    else
        player
            |> resetCombo 
            |> \player -> { player | goal = newGoal }
            |> resetHand

               
reset : Int -> Player -> Player
reset value player =
    Player [] value 0 ( 0, 0 ) ( 0, 0 )
