module Ploy where  -- do NOT CHANGE export of module

import Board

-- IMPORTS HERE
-- Note: Imports allowed that DO NOT REQUIRE TO CHANGE package.yaml, e.g.:
--       import Data.Char
import Data.Bits ( (.&.), (.|.), shift )
import Numeric (showIntAtBase)
import Data.Char (intToDigit)
import Data.Char (ord, chr)




-- #############################################################################
-- ########################### GIVEN IMPLEMENTATION ############################
-- #############################################################################

data Move = Move {start :: Pos, target :: Pos, turn :: Int}

instance Show Move where
  show (Move (Pos startC startR) (Pos tarC tarR) tr) = [startC] ++ (show startR) ++ "-" ++ [tarC] ++ show tarR ++ "-" ++ show tr

instance Eq Move where
  (==) (Move (Pos sc1 sr1) (Pos tc1 tr1) r1) (Move (Pos sc2 sr2) (Pos tc2 tr2) r2) =
      sc1 == sc2 && sr1 == sr2 && tc1 == tc2 && tr1 == tr2 && r1 == r2

rotate :: Int -> Int -> Int
rotate o tr = (.&.) ((.|.) (shift o tr) (shift o (tr-8))) 255



-- #############################################################################
-- ####################### gameFinished :: Board -> Bool #######################
-- ####################### - 3 Functional Points         #######################
-- ####################### - 1 Coverage Point            #######################
-- #############################################################################


find :: String-> [String] -> String
find _ [] = "False"
find n (x:xs)
  | x == n = "True"
  | otherwise = find n xs

check_Cell_w :: Cell -> String
check_Cell_w (Piece White 170) = "True"
check_Cell_w (Piece White 85) = "True"
check_Cell_w (Piece White _) = "others_w"
check_Cell_w _ = "False"

check_Cell_b :: Cell -> String
check_Cell_b (Piece Black 170) = "True"
check_Cell_b (Piece Black 85) = "True"
check_Cell_b (Piece Black _) = "others_b"
check_Cell_b _ = "False"


check_white :: Board -> [[String]]
check_white a = map (map check_Cell_w) a
check_black :: Board -> [[String]]
check_black a = map (map check_Cell_b) a

check_Situation :: [[String]] -> [String]
check_Situation a = map (find "True") a
check_Situation_2 :: [String] -> String
check_Situation_2 a = find "True" a
check_Situation_white :: [[String]] -> [String]
check_Situation_white a = map (find "others_w") a
check_Situation_white_1 :: [String] -> String
check_Situation_white_1  a = find "True" a
check_Situation_black :: [[String]] -> [String]
check_Situation_black a = map (find "others_b") a
check_Situation_black_1 :: [String] -> String
check_Situation_black_1 a = find "True" a


gameFinished :: Board -> Bool
gameFinished a = if ((check_Situation_white_1(check_Situation_white (check_white a )) )  == "False"  || ((check_Situation_black_1(check_Situation_black(check_black a ))) )  == "False" ) then True
else if ((check_Situation_2(check_Situation (check_white a )) )  == "True"  && ((check_Situation_2(check_Situation(check_black a ))) )  == "True" ) then False
else True

--Excellent ++ coverage

-- #############################################################################
-- ################### isValidMove :: Board -> Move -> Bool ####################
-- ################### - 5 Functional Points                ####################
-- ################### - 1 Coverage Point                   ####################
-- #############################################################################



isMember n [] = False
isMember n (x:xs)
    | n == x = True
    | otherwise = isMember n xs

lis = [1,2,4,8,16,32,64,128]
lis_p = [3,6,12,24,48,96,192,5,10,20,40,80,160,17,34,68,136,129,130]


start_mv :: Move -> Pos
start_mv (Move a b c) =a
target_mv :: Move -> Pos
target_mv (Move a b c) = b                    -- Specify start target and turn
turnn :: Move -> Int
turnn (Move a b c) = c

check_n :: Int -> Bool
check_n a = isMember a lis                    -- check if number element of list

check_n_p :: Int -> Bool
check_n_p a = isMember a lis_p

-- Cells Operations

number_cell :: Cell -> Int
number_cell Empty = 500
number_cell (Piece Black b)=b
number_cell (Piece White b)=b
check_color :: Cell -> Int
check_color (Piece Black _)=1
check_color (Piece White _)=2
check_color Empty = 3
check_type :: Cell -> Char
check_type a = if check_n((number_cell a)) == True then 'S'
--else if ( (check_n(div (number_cell a) 3) == True  && (mod (number_cell a) 3== 0) )   ||  (    (check_n(div (number_cell a) 17) == True)   &&  (mod (number_cell a) 17== 0) ) || check_n(div (number_cell a) 5) == True ) && (mod (number_cell a) 5== 0) || (number_cell a) == 129 then 'P'
else if check_n_p (number_cell a) == True then 'P'
else if ( (number_cell a) == 170 || (number_cell a) == 85 ) then 'C'
else 'L'
check_weg :: Cell -> Bool
check_weg Empty = True
check_weg _ = False

-- Cells Operations


-- Mvmt Operations

mov_str_place_colo :: Move -> Int
mov_str_place_colo a =   ord(colo(start_mv a))-97
mov_str_place_row :: Move -> Int
mov_str_place_row a = 9 - roww(start_mv a)
mov_trgt_place_colo :: Move -> Int
mov_trgt_place_colo a = ord(colo(target_mv a))-97

mov_trgt_place_row :: Move -> Int
mov_trgt_place_row a = 9 - roww(target_mv a)
pos_row :: Pos -> Int
pos_row a = 9 - roww a
pos_col :: Pos -> Int
pos_col a = ord(colo a) - 97


-- Mvmt Operations

place :: Board -> Int -> Int -> Cell
place a line col = ((a!!line)!!col)


--Possible Mvmt

num_bin :: Int -> String
num_bin x = showIntAtBase 2 intToDigit x "" -- to Binary

mvt_up :: Cell -> Bool
mvt_up cel = if (last (num_bin(number_cell cel))) == '1' then True else False
mvt_up_right :: Cell -> Bool
mvt_up_right cel = if number_cell cel < 2 then False
else if (last (init(num_bin(number_cell cel)))) == '1' then True else False
mvt_right :: Cell -> Bool
mvt_right cel = if number_cell cel < 4 then False
else if (last (init(init(num_bin(number_cell cel))))) == '1' then True else False
mvt_down_right :: Cell -> Bool
mvt_down_right cel = if number_cell cel < 8 then False
else if (last (init(init(init(num_bin(number_cell cel)))))) == '1' then True else False
mvt_down :: Cell -> Bool
mvt_down cel = if number_cell cel < 16 then False
else if (last (init(init(init(init(num_bin(number_cell cel))))))) == '1' then True else False
mvt_down_left :: Cell -> Bool
mvt_down_left cel = if number_cell cel < 32 then False
else if (last (init(init(init(init(init (num_bin(number_cell cel)))))))) == '1' then True else False
mvt_left :: Cell -> Bool
mvt_left cel = if number_cell cel < 64 then False
else if (last (init(init(init(init(init(init(num_bin(number_cell cel))))))))) == '1' then True else False
mvt_up_left :: Cell -> Bool
mvt_up_left cel = if number_cell cel < 128 then False
else if (last (init(init(init(init(init(init(init(num_bin(number_cell cel)))))))))) == '1' then True else False

--Possible Mvmt

isValidMove :: Board -> Move -> Bool
isValidMove brett beweg = if (place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg)) == Empty then False                                                                                                                                                                                                                                                                                            --no piece to move
else if (start_mv beweg == target_mv beweg) && turnn beweg >= 0 && turnn beweg <= 7 then True

else if turnn beweg > 7 || turnn beweg <0 then False                                                                                                                                                                                                                                                                                                                                                             -- Drehung false
else if (start_mv beweg /= target_mv beweg) && (check_color (place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg)) == check_color (place (brett) (mov_trgt_place_row beweg) (mov_trgt_place_colo beweg))) then False                                                                                                                                                                             -- same color at target when target not start
else if ((start_mv beweg /= target_mv beweg) && (turnn beweg > 0) && (check_type (place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))) /= 'S' ) then False                                                                                                                                                                                                                                       -- only Shield can turn and move

else if ((length(line (start_mv beweg) (target_mv beweg))))>4 then False                                                                                                                                                                                                                                                                                                                                       -- Mvmt > 3
else if (check_type (place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))) == 'S' && ((length(line (start_mv beweg) (target_mv beweg)))) > 2 then False                                                                                                                                                                                                                                         -- check length Mvmt with Shield
else if (check_type (place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))) == 'P' && ((length(line (start_mv beweg) (target_mv beweg)))) > 3 then False                                                                                                                                                                                                                                         -- Check length Mvmt with Probe

else if (check_type (place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))) == 'C' && ((length(line (start_mv beweg) (target_mv beweg)))) > 2 then False                                                                                                                                                                                                                                         -- Check length Mvmt with Commander



--else if ((length(line (start_mv beweg) (target_mv beweg)))) ==2 && check_weg( ( place (brett) (pos_row ((line (start_mv beweg) (target_mv beweg))!!1)) (pos_col ((line (start_mv beweg) (target_mv beweg))!!1))  )) == False then False                                                                                                                                                                       --Check weg empty
else if ((length(line (start_mv beweg) (target_mv beweg)))) ==3 && (check_weg( ( place (brett) (pos_row ((line (start_mv beweg) (target_mv beweg))!!1)) (pos_col ((line (start_mv beweg) (target_mv beweg))!!1))  )) == False ) then False           --Check weg empty
else if ((length(line (start_mv beweg) (target_mv beweg)))) ==4 && ( check_weg( ( place (brett) (pos_row ((line (start_mv beweg) (target_mv beweg))!!1)) (pos_col ((line (start_mv beweg) (target_mv beweg))!!1))  )) == False || check_weg( ( place (brett) (pos_row ((line (start_mv beweg) (target_mv beweg))!!2)) (pos_col ((line (start_mv beweg) (target_mv beweg))!!2))  )) == False ) then False           --Check weg empty


else if  (colo ((line (start_mv beweg) (target_mv beweg))!!1) == colo ((line (start_mv beweg) (target_mv beweg))!!0) ) && (roww ((line (start_mv beweg) (target_mv beweg))!!1) > roww ((line (start_mv beweg) (target_mv beweg))!!0) ) && mvt_up(place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))==False then False                                                                           -- check mvmt up not possible when direction false
else if (ord(colo ((line (start_mv beweg) (target_mv beweg))!!1)) > ord(colo ((line (start_mv beweg) (target_mv beweg))!!0)) ) && (roww ((line (start_mv beweg) (target_mv beweg))!!1) > roww ((line (start_mv beweg) (target_mv beweg))!!0) ) && mvt_up_right(place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))==False then False                                                             -- check mvmt up_right not possible when direction false

else if  (ord(colo ((line (start_mv beweg) (target_mv beweg))!!1)) > ord(colo ((line (start_mv beweg) (target_mv beweg))!!0)) ) && (roww ((line (start_mv beweg) (target_mv beweg))!!1) == roww ((line (start_mv beweg) (target_mv beweg))!!0) ) && mvt_right(place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))==False then False                                                              -- check mvmt right not possible when direction false

else if (ord(colo ((line (start_mv beweg) (target_mv beweg))!!1)) > ord(colo ((line (start_mv beweg) (target_mv beweg))!!0)) ) && (roww ((line (start_mv beweg) (target_mv beweg))!!1) < roww ((line (start_mv beweg) (target_mv beweg))!!0) ) && mvt_down_right(place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))==False then False                                                           -- check mvmt down_right not possible when direction false
else if  (ord(colo ((line (start_mv beweg) (target_mv beweg))!!1)) == ord(colo ((line (start_mv beweg) (target_mv beweg))!!0)) ) && (roww ((line (start_mv beweg) (target_mv beweg))!!1) < roww ((line (start_mv beweg) (target_mv beweg))!!0) ) && mvt_down(place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))==False then False                                                               -- check mvmt down not possible when direction false
else if (ord(colo ((line (start_mv beweg) (target_mv beweg))!!1)) < ord(colo ((line (start_mv beweg) (target_mv beweg))!!0)) ) && (roww ((line (start_mv beweg) (target_mv beweg))!!1) < roww ((line (start_mv beweg) (target_mv beweg))!!0) ) && mvt_down_left(place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))==False then False                                                            -- check mvmt down_left not possible when direction false
else if  (ord(colo ((line (start_mv beweg) (target_mv beweg))!!1)) < ord(colo ((line (start_mv beweg) (target_mv beweg))!!0)) ) && (roww ((line (start_mv beweg) (target_mv beweg))!!1) == roww ((line (start_mv beweg) (target_mv beweg))!!0) ) && mvt_left(place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))==False then False                                                          -- check mvmt left not possible when direction false
else if (ord(colo ((line (start_mv beweg) (target_mv beweg))!!1)) < ord(colo ((line (start_mv beweg) (target_mv beweg))!!0)) ) && (roww ((line (start_mv beweg) (target_mv beweg))!!1) > roww ((line (start_mv beweg) (target_mv beweg))!!0) ) && mvt_up_left(place (brett) (mov_str_place_row beweg) (mov_str_place_colo beweg))==False then False                                                              -- check mvmt up_left not possible when direction false

else True


-- Lance weg emty 2 pas

--Not on same line
-- Mrigula sauf left

-- #############################################################################
-- ################### possibleMoves :: Pos -> Cell -> [Move] ##################
-- ################### - 6 Functional Points                  ##################
-- ################### - 1 Coverage Point                     ##################
-- #############################################################################


add_up_moves :: Pos -> Cell -> [Move]
add_up_moves position cell = if (check_type cell == 'S') then (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+1)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+1)) 1) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+1)) 2) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+1)) 3) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+1)) 4) :(Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+1)) 5) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+1)) 6) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+1)) 7) :[]
else if (check_type cell == 'P') then (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+1)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+2)) 0) : []
else if (check_type cell == 'L') then (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+1)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+2)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+3)) 0) : []
else (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)+1)) 0) : []


add_down_moves :: Pos -> Cell -> [Move]
add_down_moves position cell = if (check_type cell == 'S') then (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-1)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-1)) 1) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-1)) 2) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-1)) 3) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-1)) 4) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-1)) 5) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-1)) 6) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-1)) 7) :[]
else if (check_type cell == 'P') then (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-1)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-2)) 0) : []
else if (check_type cell == 'L') then (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-1)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-2)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-3)) 0) : []
else (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position)-1)) 0) : []


add_right_moves :: Pos -> Cell -> [Move]
add_right_moves position cell = if (check_type cell == 'S') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position))) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position))) 1) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position))) 2) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position))) 3) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position))) 4) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position))) 5) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position))) 6) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position))) 7) : []
else if (check_type cell == 'P') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position))) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+2)) ((roww position))) 0) : []
else if (check_type cell == 'L') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position))) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+2)) ((roww position))) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+3)) ((roww position))) 0) : []
else (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position))) 0) : []


add_left_moves :: Pos -> Cell -> [Move]
add_left_moves position cell = if (check_type cell == 'S') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position))) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position))) 1) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position))) 2) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position))) 3) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position))) 4) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position))) 5) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position))) 6) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position))) 7) : []
else if (check_type cell == 'P') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position))) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-2)) ((roww position))) 0) : []
else if (check_type cell == 'L') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position))) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-2)) ((roww position))) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-3)) ((roww position))) 0) : []
else (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position))) 0) : []


add_up_right_moves :: Pos -> Cell -> [Move]
add_up_right_moves position cell = if (check_type cell == 'S') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)+1)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)+1)) 1) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)+1)) 2) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)+1)) 3) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)+1)) 4) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)+1)) 5) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)+1)) 6) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)+1)) 7) : []
else if (check_type cell == 'P') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)+1)) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+2)) ((roww position)+2)) 0) : []
else if (check_type cell == 'L') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)+1)) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+2)) ((roww position)+2)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+3)) ((roww position)+3)) 0) : []
else (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)+1)) 0) : []


add_down_right_moves :: Pos -> Cell -> [Move]
add_down_right_moves position cell =if (check_type cell == 'S') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)-1)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)-1)) 1) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)-1)) 2) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)-1)) 3) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)-1)) 4) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)-1)) 5) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)-1)) 6) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)-1)) 7) : []
else if (check_type cell == 'P') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)-1)) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+2)) ((roww position)-2)) 0) : []
else if (check_type cell == 'L') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)-1)) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+2)) ((roww position)-2)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+3)) ((roww position)-3)) 0) : []
else (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)+1)) ((roww position)-1)) 0) : []


add_down_left_moves :: Pos -> Cell -> [Move]
add_down_left_moves position cell = if (check_type cell == 'S') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)-1)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)-1)) 1) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)-1)) 2) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)-1)) 3) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)-1)) 4) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)-1)) 5) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)-1)) 6) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)-1)) 7) : []
else if (check_type cell == 'P') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)-1)) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-2)) ((roww position)-2)) 0) : []
else if (check_type cell == 'L') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)-1)) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-2)) ((roww position)-2)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-3)) ((roww position)-3)) 0) : []
else (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)-1)) 0) : []


add_up_left_moves :: Pos -> Cell -> [Move]
add_up_left_moves position cell = if (check_type cell == 'S') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)+1)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)+1)) 1) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)+1)) 2) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)+1)) 3) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)+1)) 4) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)+1)) 5) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)+1)) 6) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)+1)) 7) : []
else if (check_type cell == 'P') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)+1)) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-2)) ((roww position)+2)) 0) : []
else if (check_type cell == 'L') then (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)+1)) 0)    :        (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-2)) ((roww position)+2)) 0) : (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-3)) ((roww position)+3)) 0) : []
else (Move (Pos (colo(position)) (roww(position))) (Pos (chr(ord(colo position)-1)) ((roww position)+1)) 0) : []


add_turn_moves :: Pos -> Cell -> [Move]
add_turn_moves position cell = (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position))) 1) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position))) 2) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position))) 3) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position))) 4) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position))) 5) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position))) 6) : (Move (Pos (colo(position)) (roww(position))) (Pos (colo position) ((roww position))) 7) : []



list_char = ['a','b','c','d','e','f','g','h','i']
check_colon :: Char -> Bool
check_colon a = isMember a list_char
only_in_brett :: Move -> Bool
only_in_brett mov = if roww(start_mv mov)>0 && roww(start_mv mov)<10 && roww(target_mv mov)>0 && roww(target_mv mov)<10 && (check_colon (colo(start_mv mov))) && (check_colon (colo(target_mv mov))) then True else False
filtred_list :: [Move] -> [Move]
filtred_list a = (filter (only_in_brett)) a    -- Only Moves in the Board


possibleMoves :: Pos -> Cell -> [Move]
possibleMoves position cell = filtred_list (   add_turn_moves position cell ++  ( if (mvt_right cell ) then add_right_moves position cell else [] )      ++     (if (mvt_up cell ) then add_up_moves position cell else [])       ++       (if (mvt_left cell ) then add_left_moves position cell else [])       ++       (if (mvt_down cell ) then add_down_moves position cell else [])       ++       (if (mvt_down_left cell ) then add_down_left_moves position cell else [])       ++       (if (mvt_down_right cell ) then add_down_right_moves position cell else [])       ++       (if (mvt_up_left cell ) then add_up_left_moves position cell else [])       ++       (if (mvt_up_right cell ) then add_up_right_moves position cell else []) ++ [] )




-- #############################################################################
-- ############# IMPLEMENT listMoves :: Board -> Player -> [Move] ##############
-- ############# - 2 Functional Points                            ##############
-- ############# - 1 Coverage Point                               ##############
-- #############################################################################

color_cll :: Player -> String
color_cll (Black) = "Black"
color_cll (White) = "White"

color_plyr :: Cell -> String
color_plyr (Piece Black _) = "Black"
color_plyr (Piece White _) = "White"
color_plyr (Empty)="Empty"

only_valid :: Board -> [Move] -> [Move]
only_valid brett mov = (filter (isValidMove brett)) mov

add_moves_0_0 :: Board -> Player -> [Move]
add_moves_0_0 brett a = if (color_plyr ((brett!!0)!!0) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'a' 9) ((brett!!0)!!0) ) else []
add_moves_0_1 :: Board -> Player -> [Move]
add_moves_0_1 brett a = if (color_plyr ((brett!!0)!!1) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'b' 9 ) ((brett!!0)!!1) ) else []
add_moves_0_2 :: Board -> Player -> [Move]
add_moves_0_2 brett a = if (color_plyr ((brett!!0)!!2) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'c' 9) ((brett!!0)!!2) ) else []
add_moves_0_3 :: Board -> Player -> [Move]
add_moves_0_3 brett a = if (color_plyr ((brett!!0)!!3) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'd' 9) ((brett!!0)!!3) ) else []
add_moves_0_4 :: Board -> Player -> [Move]
add_moves_0_4 brett a = if (color_plyr ((brett!!0)!!4) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'e' 9) ((brett!!0)!!4) ) else []
add_moves_0_5 :: Board -> Player -> [Move]
add_moves_0_5 brett a = if (color_plyr ((brett!!0)!!5) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'f' 9) ((brett!!0)!!5) ) else []
add_moves_0_6 :: Board -> Player -> [Move]
add_moves_0_6 brett a = if (color_plyr ((brett!!0)!!6) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'g' 9) ((brett!!0)!!6) ) else []
add_moves_0_7 :: Board -> Player -> [Move]
add_moves_0_7 brett a = if (color_plyr ((brett!!0)!!7) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'h' 9) ((brett!!0)!!7) ) else []
add_moves_0_8 :: Board -> Player -> [Move]
add_moves_0_8 brett a = if (color_plyr ((brett!!0)!!8) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'i' 9) ((brett!!0)!!8) ) else []

add_moves_1_0 :: Board -> Player -> [Move]
add_moves_1_0 brett a = if (color_plyr ((brett!!1)!!0) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'a' 8) ((brett!!1)!!0) ) else []
add_moves_1_1 :: Board -> Player -> [Move]
add_moves_1_1 brett a = if (color_plyr ((brett!!1)!!1) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'b' 8) ((brett!!1)!!1) ) else []
add_moves_1_2 :: Board -> Player -> [Move]
add_moves_1_2 brett a = if (color_plyr ((brett!!1)!!2) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'c' 8) ((brett!!1)!!2) ) else []
add_moves_1_3 :: Board -> Player -> [Move]
add_moves_1_3 brett a = if (color_plyr ((brett!!1)!!3) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'd' 8) ((brett!!1)!!3) ) else []
add_moves_1_4 :: Board -> Player -> [Move]
add_moves_1_4 brett a = if (color_plyr ((brett!!1)!!4) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'e' 8) ((brett!!1)!!4) ) else []
add_moves_1_5 :: Board -> Player -> [Move]
add_moves_1_5 brett a = if (color_plyr ((brett!!1)!!5) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'f' 8) ((brett!!1)!!5) ) else []
add_moves_1_6 :: Board -> Player -> [Move]
add_moves_1_6 brett a = if (color_plyr ((brett!!1)!!6) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'g' 8) ((brett!!1)!!6) ) else []
add_moves_1_7 :: Board -> Player -> [Move]
add_moves_1_7 brett a = if (color_plyr ((brett!!1)!!7) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'h' 8) ((brett!!1)!!7) ) else []
add_moves_1_8 :: Board -> Player -> [Move]
add_moves_1_8 brett a = if (color_plyr ((brett!!1)!!8) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'i' 8) ((brett!!1)!!8) ) else []

add_moves_2_0 :: Board -> Player -> [Move]
add_moves_2_0 brett a = if (color_plyr ((brett!!2)!!0) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'a' 7) ((brett!!2)!!0) ) else []
add_moves_2_1 :: Board -> Player -> [Move]
add_moves_2_1 brett a = if (color_plyr ((brett!!2)!!1) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'b' 7) ((brett!!2)!!1) ) else []
add_moves_2_2 :: Board -> Player -> [Move]
add_moves_2_2 brett a = if (color_plyr ((brett!!2)!!2) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'c' 7) ((brett!!2)!!2) ) else []
add_moves_2_3 :: Board -> Player -> [Move]
add_moves_2_3 brett a = if (color_plyr ((brett!!2)!!3) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'd' 7) ((brett!!2)!!3) ) else []
add_moves_2_4 :: Board -> Player -> [Move]
add_moves_2_4 brett a = if (color_plyr ((brett!!2)!!4) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'e' 7) ((brett!!2)!!4) ) else []
add_moves_2_5 :: Board -> Player -> [Move]
add_moves_2_5 brett a = if (color_plyr ((brett!!2)!!5) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'f' 7) ((brett!!2)!!5) ) else []
add_moves_2_6 :: Board -> Player -> [Move]
add_moves_2_6 brett a = if (color_plyr ((brett!!2)!!6) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'g' 7) ((brett!!2)!!6) ) else []
add_moves_2_7 :: Board -> Player -> [Move]
add_moves_2_7 brett a = if (color_plyr ((brett!!2)!!7) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'h' 7) ((brett!!2)!!7) ) else []
add_moves_2_8 :: Board -> Player -> [Move]
add_moves_2_8 brett a = if (color_plyr ((brett!!2)!!8) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'i' 7) ((brett!!2)!!8) ) else []

add_moves_3_0 :: Board -> Player -> [Move]
add_moves_3_0 brett a = if (color_plyr ((brett!!3)!!0) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'a' 6) ((brett!!3)!!0) ) else []
add_moves_3_1 :: Board -> Player -> [Move]
add_moves_3_1 brett a = if (color_plyr ((brett!!3)!!1) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'b' 6) ((brett!!3)!!1) ) else []
add_moves_3_2 :: Board -> Player -> [Move]
add_moves_3_2 brett a = if (color_plyr ((brett!!3)!!2) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'c' 6) ((brett!!3)!!2) ) else []
add_moves_3_3 :: Board -> Player -> [Move]
add_moves_3_3 brett a = if (color_plyr ((brett!!3)!!3) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'd' 6) ((brett!!3)!!3) ) else []
add_moves_3_4 :: Board -> Player -> [Move]
add_moves_3_4 brett a = if (color_plyr ((brett!!3)!!4) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'e' 6) ((brett!!3)!!4) ) else []
add_moves_3_5 :: Board -> Player -> [Move]
add_moves_3_5 brett a = if (color_plyr ((brett!!3)!!5) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'f' 6) ((brett!!3)!!5) ) else []
add_moves_3_6 :: Board -> Player -> [Move]
add_moves_3_6 brett a = if (color_plyr ((brett!!3)!!6) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'g' 6) ((brett!!3)!!6) ) else []
add_moves_3_7 :: Board -> Player -> [Move]
add_moves_3_7 brett a = if (color_plyr ((brett!!3)!!7) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'h' 6) ((brett!!3)!!7) ) else []
add_moves_3_8 :: Board -> Player -> [Move]
add_moves_3_8 brett a = if (color_plyr ((brett!!3)!!8) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'i' 6) ((brett!!3)!!8) ) else []

add_moves_4_0 :: Board -> Player -> [Move]
add_moves_4_0 brett a = if (color_plyr ((brett!!4)!!0) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'a' 5) ((brett!!4)!!0) ) else []
add_moves_4_1 :: Board -> Player -> [Move]
add_moves_4_1 brett a = if (color_plyr ((brett!!4)!!1) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'b' 5) ((brett!!4)!!1) ) else []
add_moves_4_2 :: Board -> Player -> [Move]
add_moves_4_2 brett a = if (color_plyr ((brett!!4)!!2) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'c' 5) ((brett!!4)!!2) ) else []
add_moves_4_3 :: Board -> Player -> [Move]
add_moves_4_3 brett a = if (color_plyr ((brett!!4)!!3) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'd' 5) ((brett!!4)!!3) ) else []
add_moves_4_4 :: Board -> Player -> [Move]
add_moves_4_4 brett a = if (color_plyr ((brett!!4)!!4) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'e' 5) ((brett!!4)!!4) ) else []
add_moves_4_5 :: Board -> Player -> [Move]
add_moves_4_5 brett a = if (color_plyr ((brett!!4)!!5) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'f' 5) ((brett!!4)!!5) ) else []
add_moves_4_6 :: Board -> Player -> [Move]
add_moves_4_6 brett a = if (color_plyr ((brett!!4)!!6) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'g' 5) ((brett!!4)!!6) ) else []
add_moves_4_7 :: Board -> Player -> [Move]
add_moves_4_7 brett a = if (color_plyr ((brett!!4)!!7) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'h' 5) ((brett!!4)!!7) ) else []
add_moves_4_8 :: Board -> Player -> [Move]
add_moves_4_8 brett a = if (color_plyr ((brett!!4)!!8) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'i' 5) ((brett!!4)!!8) ) else []

add_moves_5_0 :: Board -> Player -> [Move]
add_moves_5_0 brett a = if (color_plyr ((brett!!5)!!0) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'a' 4) ((brett!!5)!!0) ) else []
add_moves_5_1 :: Board -> Player -> [Move]
add_moves_5_1 brett a = if (color_plyr ((brett!!5)!!1) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'b' 4) ((brett!!5)!!1) ) else []
add_moves_5_2 :: Board -> Player -> [Move]
add_moves_5_2 brett a = if (color_plyr ((brett!!5)!!2) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'c' 4) ((brett!!5)!!2) ) else []
add_moves_5_3 :: Board -> Player -> [Move]
add_moves_5_3 brett a = if (color_plyr ((brett!!5)!!3) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'd' 4) ((brett!!5)!!3) ) else []
add_moves_5_4 :: Board -> Player -> [Move]
add_moves_5_4 brett a = if (color_plyr ((brett!!5)!!4) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'e' 4) ((brett!!5)!!4) ) else []
add_moves_5_5 :: Board -> Player -> [Move]
add_moves_5_5 brett a = if (color_plyr ((brett!!5)!!5) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'f' 4) ((brett!!5)!!5) ) else []
add_moves_5_6 :: Board -> Player -> [Move]
add_moves_5_6 brett a = if (color_plyr ((brett!!5)!!6) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'g' 4) ((brett!!5)!!6) ) else []
add_moves_5_7 :: Board -> Player -> [Move]
add_moves_5_7 brett a = if (color_plyr ((brett!!5)!!7) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'h' 4) ((brett!!5)!!7) ) else []
add_moves_5_8 :: Board -> Player -> [Move]
add_moves_5_8 brett a = if (color_plyr ((brett!!5)!!8) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'i' 4) ((brett!!5)!!8) ) else []

add_moves_6_0 :: Board -> Player -> [Move]
add_moves_6_0 brett a = if (color_plyr ((brett!!6)!!0) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'a' 3) ((brett!!6)!!0) ) else []
add_moves_6_1 :: Board -> Player -> [Move]
add_moves_6_1 brett a = if (color_plyr ((brett!!6)!!1) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'b' 3) ((brett!!6)!!1) ) else []
add_moves_6_2 :: Board -> Player -> [Move]
add_moves_6_2 brett a = if (color_plyr ((brett!!6)!!2) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'c' 3) ((brett!!6)!!2) ) else []
add_moves_6_3 :: Board -> Player -> [Move]
add_moves_6_3 brett a = if (color_plyr ((brett!!6)!!3) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'd' 3) ((brett!!6)!!3) ) else []
add_moves_6_4 :: Board -> Player -> [Move]
add_moves_6_4 brett a = if (color_plyr ((brett!!6)!!4) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'e' 3) ((brett!!6)!!4) ) else []
add_moves_6_5 :: Board -> Player -> [Move]
add_moves_6_5 brett a = if (color_plyr ((brett!!6)!!5) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'f' 3) ((brett!!6)!!5) ) else []
add_moves_6_6 :: Board -> Player -> [Move]
add_moves_6_6 brett a = if (color_plyr ((brett!!6)!!6) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'g' 3) ((brett!!6)!!6) ) else []
add_moves_6_7 :: Board -> Player -> [Move]
add_moves_6_7 brett a = if (color_plyr ((brett!!6)!!7) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'h' 3) ((brett!!6)!!7) ) else []
add_moves_6_8 :: Board -> Player -> [Move]
add_moves_6_8 brett a = if (color_plyr ((brett!!6)!!8) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'i' 3) ((brett!!6)!!8) ) else []

add_moves_7_0 :: Board -> Player -> [Move]
add_moves_7_0 brett a = if (color_plyr ((brett!!7)!!0) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'a' 2) ((brett!!7)!!0) ) else []
add_moves_7_1 :: Board -> Player -> [Move]
add_moves_7_1 brett a = if (color_plyr ((brett!!7)!!1) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'b' 2) ((brett!!7)!!1) ) else []
add_moves_7_2 :: Board -> Player -> [Move]
add_moves_7_2 brett a = if (color_plyr ((brett!!7)!!2) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'c' 2) ((brett!!7)!!2) ) else []
add_moves_7_3 :: Board -> Player -> [Move]
add_moves_7_3 brett a = if (color_plyr ((brett!!7)!!3) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'd' 2) ((brett!!7)!!3) ) else []
add_moves_7_4 :: Board -> Player -> [Move]
add_moves_7_4 brett a = if (color_plyr ((brett!!7)!!4) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'e' 2) ((brett!!7)!!4) ) else []
add_moves_7_5 :: Board -> Player -> [Move]
add_moves_7_5 brett a = if (color_plyr ((brett!!7)!!5) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'f' 2) ((brett!!7)!!5) ) else []
add_moves_7_6 :: Board -> Player -> [Move]
add_moves_7_6 brett a = if (color_plyr ((brett!!7)!!6) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'g' 2) ((brett!!7)!!6) ) else []
add_moves_7_7 :: Board -> Player -> [Move]
add_moves_7_7 brett a = if (color_plyr ((brett!!7)!!7) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'h' 2) ((brett!!7)!!7) ) else []
add_moves_7_8 :: Board -> Player -> [Move]
add_moves_7_8 brett a = if (color_plyr ((brett!!7)!!8) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'i' 2) ((brett!!7)!!8) ) else []

add_moves_8_0 :: Board -> Player -> [Move]
add_moves_8_0 brett a = if (color_plyr ((brett!!8)!!0) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'a' 1) ((brett!!8)!!0) ) else []
add_moves_8_1 :: Board -> Player -> [Move]
add_moves_8_1 brett a = if (color_plyr ((brett!!8)!!1) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'b' 1) ((brett!!8)!!1) ) else []
add_moves_8_2 :: Board -> Player -> [Move]
add_moves_8_2 brett a = if (color_plyr ((brett!!8)!!2) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'c' 1) ((brett!!8)!!2) ) else []
add_moves_8_3 :: Board -> Player -> [Move]
add_moves_8_3 brett a = if (color_plyr ((brett!!8)!!3) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'd' 1) ((brett!!8)!!3) ) else []
add_moves_8_4 :: Board -> Player -> [Move]
add_moves_8_4 brett a = if (color_plyr ((brett!!8)!!4) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'e' 1) ((brett!!8)!!4) ) else []
add_moves_8_5 :: Board -> Player -> [Move]
add_moves_8_5 brett a = if (color_plyr ((brett!!8)!!5) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'f' 1) ((brett!!8)!!5) ) else []
add_moves_8_6 :: Board -> Player -> [Move]
add_moves_8_6 brett a = if (color_plyr ((brett!!8)!!6) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'g' 1) ((brett!!8)!!6) ) else []
add_moves_8_7 :: Board -> Player -> [Move]
add_moves_8_7 brett a = if (color_plyr ((brett!!8)!!7) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'h' 1) ((brett!!8)!!7) ) else []
add_moves_8_8 :: Board -> Player -> [Move]
add_moves_8_8 brett a = if (color_plyr ((brett!!8)!!8) == color_cll a) then only_valid (brett) (possibleMoves (Pos 'i' 1) ((brett!!8)!!8) ) else []



listMoves_1 :: Board -> Player -> [Move]
listMoves_1 brett a = add_moves_0_0 (brett) (a) ++ add_moves_0_1 (brett) (a) ++ add_moves_0_2 (brett) (a) ++ add_moves_0_3 (brett) (a) ++ add_moves_0_4 (brett) (a) ++ add_moves_0_5 (brett) (a) ++ add_moves_0_6 (brett) (a) ++ add_moves_0_7 (brett) (a) ++ add_moves_0_8 (brett) (a) ++ add_moves_1_0 (brett) (a) ++ add_moves_1_1 (brett) (a) ++ add_moves_1_2 (brett) (a) ++ add_moves_1_3 (brett) (a) ++ add_moves_1_4 (brett) (a) ++ add_moves_1_5 (brett) (a) ++ add_moves_1_6 (brett) (a) ++ add_moves_1_7 (brett) (a) ++ add_moves_1_8 (brett) (a) ++ add_moves_2_0 (brett) (a) ++ add_moves_2_1 (brett) (a) ++ add_moves_2_2 (brett) (a) ++ add_moves_2_3 (brett) (a) ++ add_moves_2_4 (brett) (a) ++ add_moves_2_5 (brett) (a) ++ add_moves_2_6 (brett) (a) ++ add_moves_2_7 (brett) (a) ++ add_moves_2_8 (brett) (a) ++ []

listMoves_2 :: Board -> Player -> [Move]
listMoves_2 brett a =  add_moves_3_0 (brett) (a) ++ add_moves_3_1 (brett) (a) ++ add_moves_3_2 (brett) (a) ++ add_moves_3_3 (brett) (a) ++ add_moves_3_4 (brett) (a) ++ add_moves_3_5 (brett) (a) ++ add_moves_3_6 (brett) (a) ++ add_moves_3_7 (brett) (a) ++ add_moves_3_8 (brett) (a) ++ add_moves_4_0 (brett) (a) ++ add_moves_4_1 (brett) (a) ++ add_moves_4_2 (brett) (a) ++ add_moves_4_3 (brett) (a) ++ add_moves_4_4 (brett) (a) ++ add_moves_4_5 (brett) (a) ++ add_moves_4_6 (brett) (a) ++ add_moves_4_7 (brett) (a) ++ add_moves_4_8 (brett) (a) ++ add_moves_5_0 (brett) (a) ++ add_moves_5_1 (brett) (a) ++ add_moves_5_2 (brett) (a) ++ add_moves_5_3 (brett) (a) ++ add_moves_5_4 (brett) (a) ++ add_moves_5_5 (brett) (a) ++ add_moves_5_6 (brett) (a) ++ add_moves_5_7 (brett) (a) ++ add_moves_5_8 (brett) (a) ++ []

listMoves_3 :: Board -> Player -> [Move]
listMoves_3 brett a = add_moves_6_0 (brett) (a) ++ add_moves_6_1 (brett) (a) ++ add_moves_6_2 (brett) (a) ++ add_moves_6_3 (brett) (a) ++ add_moves_6_4 (brett) (a) ++ add_moves_6_5 (brett) (a) ++ add_moves_6_6 (brett) (a) ++ add_moves_6_7 (brett) (a) ++ add_moves_6_8 (brett) (a) ++ add_moves_7_0 (brett) (a) ++ add_moves_7_1 (brett) (a) ++ add_moves_7_2 (brett) (a) ++ add_moves_7_3 (brett) (a) ++ add_moves_7_4 (brett) (a) ++ add_moves_7_5 (brett) (a) ++ add_moves_7_6 (brett) (a) ++ add_moves_7_7 (brett) (a) ++ add_moves_7_8 (brett) (a) ++ add_moves_8_0 (brett) (a) ++ add_moves_8_1 (brett) (a) ++ add_moves_8_2 (brett) (a) ++ add_moves_8_3 (brett) (a) ++ add_moves_8_4 (brett) (a) ++ add_moves_8_5 (brett) (a) ++ add_moves_8_6 (brett) (a) ++ add_moves_8_7 (brett) (a) ++ add_moves_8_8 (brett) (a) ++ []

listMoves :: Board -> Player -> [Move]
listMoves brett a = if gameFinished brett == True then [] else listMoves_1 brett a ++ listMoves_2 brett a ++ listMoves_3 brett a ++ []

-- Mrigula ema lezem blech mvmt left
