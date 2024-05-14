module Board where  -- do NOT CHANGE export of module

-- IMPORTS HERE
-- Note: Imports allowed that DO NOT REQUIRE TO CHANGE package.yaml, e.g.:
--       import Data.Chars
import Data.List.Split
import Data.Char (ord, chr)



-- #############################################################################
-- ############# GIVEN IMPLEMENTATION                           ################
-- ############# Note: "deriving Show" may be deleted if needed ################
-- #############       Given data types may NOT be changed      ################
-- #############################################################################

data Player = Black | White deriving Show
data Cell = Piece Player Int | Empty deriving Show
data Pos = Pos { col :: Char, row :: Int } deriving Show
type Board = [[Cell]]

instance Eq Pos where
  (==) (Pos c1 r1) (Pos c2 r2) = (c1 == c2) && (r1 == r2)

instance Eq Player where
  (==) Black Black = True
  (==) White White = True
  (==) _ _ = False

instance Eq Cell where
  (==) Empty Empty = True
  (==) (Piece p1 i1) (Piece p2 i2) = p1 == p2 && i1 == i2
  (==) _ _ = False

-- #############################################################################
-- ################# IMPLEMENT validateFEN :: String -> Bool ###################
-- ################## - 2 Functional Points                  ###################
-- ################## - 1 Coverage Point                     ###################
-- #############################################################################
isMember1 n [] = False
isMember1 n (x:xs)
    | n == x = True
    | otherwise = isMember1 n xs


filter_all :: Char -> Bool
filter_all ',' = True
filter_all ('/') = True
filter_all ('w') = True
filter_all ('b') = True
filter_all ('0') = True
filter_all ('1') = True
filter_all ('2') = True
filter_all ('3') = True
filter_all ('4') = True
filter_all ('5') = True
filter_all ('6') = True
filter_all ('7') = True
filter_all ('8') = True
filter_all ('9') = True
filter_all _ = False

composition :: String -> Bool
composition a = not (isMember1 (False) (map filter_all a) )        -- allowed characters are numbers , w , b , ',' , /

split_sl :: String -> [String]
split_sl s = splitOn "/" s
spli_komm :: String -> [String]
spli_komm s = splitOn "," s
splitBoard :: String -> [[String]]
splitBoard s = map spli_komm (split_sl s)

first_w_b_empty :: String -> Bool
first_w_b_empty "" = True
first_w_b_empty a = if head a == 'w' || head a == 'b' then True else False
check_fst :: String -> Bool
check_fst a= not (isMember1 (True) (map (isMember1 (False)) ((map (map first_w_b_empty) (splitBoard a)) ))) -- first is 'w' or 'b' or empty

num_255 :: String -> Bool
num_255 "" = True
num_255 "w" = True
num_255 "b" = True
num_255 a = if (read (tail(a)) :: Int) > 0 && (read (tail(a)) :: Int) < 256 then True else False
check_numbers_corr :: String -> Bool
check_numbers_corr a = not (isMember1 (True) (map (isMember1 (False)) ((map (map num_255) (splitBoard a)) )))  --number between 1 and 255

only_b_w :: String -> Bool
only_b_w a = if length a == 1 then False else True
check_length :: String -> Bool
check_length a = not (isMember1 (True) (map (isMember1 (False)) ((map (map only_b_w) (splitBoard a)) )))  --number between 1 and 255

--only_w :: String -> Bool

iskoma_sl :: Char -> Bool
iskoma_sl ',' = True
iskoma_sl ('/') = True
iskoma_sl _ = False

validateFEN :: String -> Bool
validateFEN a = if composition a == False then False
else if check_fst a == False then False
else if check_numbers_corr a == False then False
else if check_length a == False then False
else if ((filter (iskoma_sl)) a /= ",,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,") then False
else True


--Excellent ++ coverage

-- #############################################################################
-- ####################### buildBoard :: String -> Board #######################
-- ####################### - 2 Functional Points         #######################
-- ####################### - 1 Coverage Point            #######################
-- #############################################################################


transformCell :: String -> Cell
transformCell "" = Empty
transformCell (x:xs) = if x == 'w' then Piece White (read (xs) :: Int)
else if x=='b' then Piece Black (read (xs) :: Int ) else error "false"

getCells :: [[String]] -> Board
getCells list = map (map transformCell )list


buildBoard :: String -> Board
buildBoard s = (getCells (splitBoard s))


--Excellent ++ coverage


-- #############################################################################
-- ####################### line :: Pos -> Pos -> [Pos]  ########################
-- ####################### - 3 Functional Points        ########################
-- ####################### - 1 Coverage Point           ########################
-- #############################################################################




colo :: Pos -> Char
colo (Pos a b)= a

roww :: Pos -> Int
roww (Pos a b) = b



line_right :: Pos -> Pos -> [Pos]
line_right a b = if ((roww a) == (roww b) && (ord(colo a)) < (ord(colo b)+1)) then  a : line_right (Pos (chr(ord(colo a) + 1)) (roww a)) b else []

line_left :: Pos -> Pos -> [Pos]
line_left a b = if ((roww a) == (roww b) && (ord(colo a)) > (ord(colo b)-1)) then  a : line_left (Pos (chr(ord(colo a) - 1)) (roww a)) b else []

line_down :: Pos -> Pos -> [Pos]
line_down a b = if ((colo a) == (colo b) && roww a >= roww b ) then  a : line_down (Pos (colo a) ((roww a)-1)) b else []                       -- Movement down

line_up :: Pos -> Pos -> [Pos]
line_up a b = if ((colo a) == (colo b) && roww a <= roww b ) then  a : line_up (Pos (colo a) ((roww a)+1)) b else []

line_up_right :: Pos -> Pos -> [Pos]
line_up_right a b = if ((ord(colo a)) < (ord(colo b)) && roww a < roww b  ) then  a : line_up_right (Pos (chr(ord(colo a) + 1)) ((roww a)+1)) b  else b:[]

line_up_left :: Pos -> Pos -> [Pos]
line_up_left a b = if ((ord(colo a)) > (ord(colo b)) && roww a < roww b  ) then  a : line_up_left (Pos (chr(ord(colo a) - 1)) ((roww a)+1)) b  else b:[]

line_down_right :: Pos -> Pos -> [Pos]
line_down_right a b = if ((ord(colo a)) < (ord(colo b)) && roww a > roww b  ) then  a : line_down_right (Pos (chr(ord(colo a) + 1)) ((roww a)-1)) b  else b:[]

line_down_left :: Pos -> Pos -> [Pos]
line_down_left a b = if ((ord(colo a)) > (ord(colo b)) && roww a > roww b  ) then  a : line_down_left (Pos (chr(ord(colo a) - 1)) ((roww a)-1)) b  else b:[]

line :: Pos -> Pos -> [Pos]
line a b = if ((roww a) == (roww b) && (ord(colo a)) < (ord(colo b)+1)) then line_right a b
else if ((roww a) == (roww b) && (ord(colo a)) > (ord(colo b)-1)) then line_left a b
else if ((colo a) == (colo b) && roww a > roww b ) then line_down a b
else if ((ord(colo a)) < (ord(colo b)) && roww a < roww b  ) then line_up_right a b
else if ((ord(colo a)) > (ord(colo b)) && roww a < roww b  ) then line_up_left a b
else if ((ord(colo a)) < (ord(colo b)) && roww a > roww b  ) then line_down_right a b
else if ((ord(colo a)) > (ord(colo b)) && roww a > roww b  ) then line_down_left a b
else line_up a b




-- mvmt left ++ coverage okk
