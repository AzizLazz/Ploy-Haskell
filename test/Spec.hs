-- #############################################################################
-- ########### YOUR UNIT TESTS                                    ##############
-- ########### Note: execute tests using "stack test ploy:units"  ##############
-- #############################################################################

import Test.Hspec

import Board
    ( buildBoard,
      line,
      validateFEN,
      Board,
      Cell(Empty, Piece),
      Player(Black, White),
      Pos(Pos) )
import Ploy ( gameFinished, isValidMove, listMoves, Move(Move), possibleMoves)

main :: IO ()
main = hspec $ do
    testValidateFEN
    testBuildBoard
    testLine
    testGameFinished
    testIsValidMove
    testPossibleMoves
    testListMoves





sampleBoard300 :: Board
sampleBoard300 = [[Empty,Piece White 84,Piece White 41,Piece White 56,Empty,Piece White 56,Piece White 41,Piece White 84,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 16,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Piece Black 1,Empty,Piece Black 2,Piece Black 1,Piece Black 1,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 170,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]



sampleBoard_list_10 :: Board
sampleBoard_list_10 =[[Piece White 16,Piece White 16,Piece White 16,Piece White 16,Piece White 16,Piece White 16,Piece White 16,Piece White 16,Piece White 16],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Piece White 170,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Empty,Empty,Empty,Piece Black 170,Empty]]



sampleBoard_list_9 :: Board
sampleBoard_list_9 =[[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Piece White 170,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Empty,Empty,Empty,Piece Black 170,Empty]]



sampleBoard_list_8 :: Board
sampleBoard_list_8 =[[Empty,Piece White 170,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Empty,Empty,Empty,Piece Black 170,Empty]]



sampleBoard_list_7 :: Board
sampleBoard_list_7 =[[Empty,Piece White 170,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Empty,Empty,Empty,Piece Black 170,Empty]]


sampleBoard_list_6 :: Board
sampleBoard_list_6 =[[Empty,Piece White 170,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Empty,Empty,Empty,Piece Black 170,Empty]]


sampleBoard_list_5 :: Board
sampleBoard_list_5 =[[Empty,Piece White 170,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Empty,Empty,Empty,Piece Black 170,Empty]]



sampleBoard_list_4 :: Board
sampleBoard_list_4 =[[Empty,Piece White 170,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Empty,Empty,Empty,Piece Black 170,Empty]]



sampleBoard_list_3 :: Board
sampleBoard_list_3 =[[Empty,Piece White 170,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1],[Empty,Empty,Empty,Piece Black 1,Empty,Empty,Empty,Piece Black 170,Empty]]



sampleBoard_list_2 :: Board
sampleBoard_list_2 =[[Empty,Piece White 170,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Empty,Empty,Empty,Piece Black 170,Empty],[Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1,Piece White 1]]



sampleBoard_list_1 :: Board
sampleBoard_list_1 =[[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Empty,Empty,Empty,Piece Black 170,Empty],[Piece White 170,Empty,Empty,Empty,Empty,Piece White 3,Empty,Empty,Empty]]


sampleBoard_list :: Board
sampleBoard_list = [[Piece Black 17,Piece Black 84,Piece White 41,Piece White 56,Empty,Piece White 56,Piece White 41,Piece White 20,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 16,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Piece Black 1,Piece Black 1,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 5,Piece Black 146,Piece Black 131,Piece Black 170,Piece White 170,Piece Black 170,Piece Black 5,Empty]]

sampleBoard1000 :: Board
sampleBoard1000 = [[Empty,Piece White 84,Piece White 41,Piece White 56,Empty,Piece White 170,Piece White 41,Piece White 84,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 16,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Piece Black 85,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 2,Piece Black 1,Piece Black 1,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Empty,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]



sampleBoar :: Board
sampleBoar = [[Empty,Piece White 84,Piece White 41,Piece White 56,Piece White 170,Piece White 56,Piece White 41,Piece White 84,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 16,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Empty,Piece Black 9,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Empty,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 170,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]

sampleBoard :: Board
sampleBoard = [[Empty,Piece White 84,Piece White 41,Piece White 56,Empty,Piece White 56,Piece White 41,Piece White 84,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 16,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 2,Piece Black 1,Piece Black 1,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 170,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]

sampleBoard20 :: Board
sampleBoard20 = [[Empty,Piece White 1,Piece White 41,Piece White 56,Empty,Piece White 56,Piece White 41,Piece White 84,Empty],[Empty,Empty,Empty,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 64,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 2,Piece Black 1,Empty,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 170,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]

sampleBoard11 :: Board
sampleBoard11 = [[Empty,Piece White 84,Piece White 41,Piece White 56,Empty,Piece White 56,Piece White 41,Piece White 84,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 64,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Piece Black 11,Empty,Empty,Piece Black 2,Piece Black 1,Empty,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Piece Black 1,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 170,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]

sampleBoard10 :: Board
sampleBoard10 = [[Empty,Piece White 84,Piece White 41,Piece White 56,Empty,Piece White 56,Piece White 41,Piece White 84,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 64,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 2,Piece Black 1,Piece Black 1,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 170,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]

sampleBoard1 :: Board
sampleBoard1 = [[Empty,Piece White 84,Piece White 41,Piece White 170,Empty,Piece White 56,Piece White 41,Piece White 84,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 16,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Piece Black 1,Piece Black 1,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 170,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]

sampleBoard2 :: Board
sampleBoard2 = [[Empty,Piece White 84,Piece White 41,Piece White 170,Empty,Piece White 56,Piece White 41,Piece White 84,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 16,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Piece Black 1,Piece Black 1,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 17,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]

sampleBoard3 :: Board
sampleBoard3 = [[Empty,Piece White 84,Piece White 41,Piece White 170,Empty,Piece White 56,Piece White 41,Piece White 84,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 16,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Piece Black 1,Piece Black 1,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 85,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]

sampleBoard4 :: Board
sampleBoard4 = [[Empty,Piece White 84,Piece White 41,Piece White 85,Empty,Piece White 56,Piece White 41,Piece White 84,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 16,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Piece Black 1,Piece Black 1,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 17,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]

sampleBoard6 :: Board
sampleBoard6 = [[Empty,Empty,Empty,Piece White 85,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Piece Black 1,Piece Black 1,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 17,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]

sampleBoard5 :: Board
sampleBoard5 = [[Empty,Empty,Empty,Piece Black 85,Empty,Empty,Piece White 11,Piece White 23,Empty],[Empty,Piece White 170,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty]]


testValidateFEN :: Spec
testValidateFEN = describe "Module Board: validateFEN ..." $ do
        it "fen has 9 rows" $ do
            validateFEN ",,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,," `shouldBe` (True :: Bool)

        it "fen has only b" $ do
            validateFEN ",,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,b,,,/,,,,,,,,/,,,,,,,," `shouldBe` (False :: Bool)

        it "fen has only w" $ do
            validateFEN ",,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,w,,,/,,,,,,,,/,,,,,,,," `shouldBe` (False :: Bool)

        it "fen has a number smaller then 1" $ do
            validateFEN ",,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,b0,,,/,,,,,,,,/,,,,,,,," `shouldBe` (False :: Bool)

        it "fen has a number greater than 255" $ do
            validateFEN ",,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,b256,,,/,,,,,,,,/,,,,,,,," `shouldBe` (False :: Bool)

        it "fen has a character different from w or b or empty" $ do
            validateFEN ",,,,,,,,/,,,,,,,,/,,,,,,,,/,,n,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,b3,,,/,,,,,,,,/,,,,,,,," `shouldBe` (False :: Bool)

        it "fen has one comma missing" $ do
            validateFEN ",,,,,,,,/,,,,,,,,/,,,,,,,/,,n,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,," `shouldBe` (False :: Bool)

        it "fen has one / missing" $ do
            validateFEN ",,,,,,,,/,,,,,,,,/,,,,,,,,/,,n,,,,,,/,,,,,,,,,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,," `shouldBe` (False :: Bool)

        it "fen has head not w or b" $ do
            validateFEN ",,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,23w,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,," `shouldBe` (False :: Bool)

        it "fen has good numbers" $ do
            validateFEN ",,,,,,,,/,,,,,,,,/,,,,,,b11,,/,,,b63,,,,,/,,,w34,,,,,/,,,,,w32,,,/,,,,,w98,,,/,,,,,b76,,,/,,,,,,,," `shouldBe` (True :: Bool)

        it "fen has good numbers" $ do
            validateFEN ",,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,w170,,/,,,,,w34,,,/,,,,,,,,/,,,,b3,,,/,,,,,,,,/,,,,,,,,," `shouldBe` (False :: Bool)

        it "fen has not nine rows " $ do
            validateFEN ",,,,,,,,/,,,,,,,," `shouldBe` (False :: Bool)


testBuildBoard :: Spec
testBuildBoard = describe "Module Board: buildBoard ..." $ do
        it "build board with piece white" $ do
            buildBoard ",,w12,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,," `shouldBe` [[Empty,Empty,Piece White 12,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty]]

        it "build empty board with piece black" $ do
            buildBoard ",,w12,,,,,,/b34,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,," `shouldBe` [[Empty,Empty,Piece White 12,Empty,Empty,Empty,Empty,Empty,Empty],[Piece Black 34,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty]]

        it "build empty board" $ do
            buildBoard ",,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,,,,,," `shouldBe` [[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty]]

        it "build empty board" $ do
            buildBoard ",w84,w41,w56,w170,w56,w41,w84,/,,w24,w40,w17,w40,w48,,/,,,w16,w16,w16,,,/,,,,,,,,/,,,,,,,,/,,,,,,,,/,,,b1,b1,b1,,,/,,b3,b130,b17,b130,b129,,/,b69,b146,b131,b170,b131,b146,b69," `shouldBe` [[Empty,Piece White 84,Piece White 41,Piece White 56,Piece White 170,Piece White 56,Piece White 41,Piece White 84,Empty],[Empty,Empty,Piece White 24,Piece White 40,Piece White 17,Piece White 40,Piece White 48,Empty,Empty],[Empty,Empty,Empty,Piece White 16,Piece White 16,Piece White 16,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty],[Empty,Empty,Empty,Piece Black 1,Piece Black 1,Piece Black 1,Empty,Empty,Empty],[Empty,Empty,Piece Black 3,Piece Black 130,Piece Black 17,Piece Black 130,Piece Black 129,Empty,Empty],[Empty,Piece Black 69,Piece Black 146,Piece Black 131,Piece Black 170,Piece Black 131,Piece Black 146,Piece Black 69,Empty]]








testLine :: Spec
testLine = describe "Module Board: line ..." $ do
        it "start is target" $ do
            line (Pos 'a' 1) (Pos 'a' 1) `shouldBe` ([(Pos 'a' 1)] :: [Pos])
        it "mvt up" $ do
            line (Pos 'a' 1) (Pos 'a' 3) `shouldBe` ([(Pos 'a' 1),(Pos 'a' 2),(Pos 'a' 3)] :: [Pos])

        it "mvt down" $ do
            line (Pos 'a' 3) (Pos 'a' 1) `shouldBe` ([(Pos 'a' 3),(Pos 'a' 2),(Pos 'a' 1)] :: [Pos])

        it "mvt right" $ do
            line (Pos 'a' 3) (Pos 'c' 3) `shouldBe` ([(Pos 'a' 3),(Pos 'b' 3),(Pos 'c' 3)] :: [Pos])

        it "mvt up right" $ do
            line (Pos 'a' 3) (Pos 'c' 5) `shouldBe` ([(Pos 'a' 3),(Pos 'b' 4),(Pos 'c' 5)] :: [Pos])

        it "mvt up left" $ do
            line (Pos 'e' 3) (Pos 'b' 6) `shouldBe` ([(Pos 'e' 3),(Pos 'd' 4),(Pos 'c' 5),(Pos 'b' 6)] :: [Pos])

        it "mvt down right" $ do
            line (Pos 'e' 7) (Pos 'g' 5) `shouldBe` ([(Pos 'e' 7),(Pos 'f' 6),(Pos 'g' 5)] :: [Pos])

        it "mvt down left" $ do
            line (Pos 'e' 7) (Pos 'c' 5) `shouldBe` ([(Pos 'e' 7),(Pos 'd' 6),(Pos 'c' 5)] :: [Pos])

        it "mvt left" $ do
            line (Pos 'e' 3) (Pos 'c' 3) `shouldBe` ([(Pos 'e' 3),(Pos 'd' 3),(Pos 'c' 3)] :: [Pos])



testGameFinished :: Spec
testGameFinished = describe "Module Game: gameFinished ..." $ do
        it "start board finished no commander white" $ do
            gameFinished sampleBoard `shouldBe` (True :: Bool)

        it "two commander + other pieces" $ do
            gameFinished sampleBoard1 `shouldBe` (False :: Bool)

        it "start board not finished comander white 85" $ do
            gameFinished sampleBoard3 `shouldBe` (False :: Bool)

        it "start board finished no commander black" $ do
            gameFinished sampleBoard2 `shouldBe` (True :: Bool)

        it "start board finished no commander black 85" $ do
            gameFinished sampleBoard4 `shouldBe` (True :: Bool)

        it "start board finished only commander black" $ do
            gameFinished sampleBoard5 `shouldBe` (True :: Bool)
        it "start board finished only commander White" $ do
            gameFinished sampleBoard6 `shouldBe` (True :: Bool)



testIsValidMove :: Spec
testIsValidMove = describe "Module Game: isValidMove ..." $ do
        it "1" $ do
            isValidMove sampleBoar (Move (Pos 'c' 1) (Pos 'c' 1) 1) `shouldBe` (True :: Bool)
        it "2" $ do
            isValidMove sampleBoar (Move (Pos 'd' 4) (Pos 'd' 5) 0) `shouldBe` (False :: Bool)
        it "3" $ do
            isValidMove sampleBoar (Move (Pos 'c' 1) (Pos 'c' 1) 9) `shouldBe` (False :: Bool)
        it "4" $ do
            isValidMove sampleBoar (Move (Pos 'c' 1) (Pos 'c' 1) 10) `shouldBe` (False :: Bool)
        it "5" $ do
            isValidMove sampleBoar (Move (Pos 'd' 2) (Pos 'd' 3) 0) `shouldBe` (False :: Bool)
        it "6" $ do
            isValidMove sampleBoar (Move (Pos 'g' 1) (Pos 'g' 2) 3) `shouldBe` (False :: Bool)
        it "7" $ do
            isValidMove sampleBoar (Move (Pos 'c' 1) (Pos 'c' 5) 0) `shouldBe` (False :: Bool)
        it "8" $ do
            isValidMove sampleBoar (Move (Pos 'g' 1) (Pos 'd' 4) 0) `shouldBe` (False :: Bool)
        it "9" $ do
            isValidMove sampleBoar (Move (Pos 'd' 2) (Pos 'd' 4) 0) `shouldBe` (False :: Bool)

        it "10" $ do
            isValidMove sampleBoar (Move (Pos 'f' 3) (Pos 'f' 4) 3) `shouldBe` (False :: Bool)

        it "11" $ do
            isValidMove sampleBoar (Move (Pos 'd' 3) (Pos 'd' 5) 0) `shouldBe` (False :: Bool)

        it "12" $ do
            isValidMove sampleBoar (Move (Pos 'd' 2) (Pos 'd' 5) 0) `shouldBe` (False :: Bool)

        it "13" $ do
            isValidMove sampleBoar (Move (Pos 'e' 1) (Pos 'e' 3) 0) `shouldBe` (False :: Bool)--here

        it "14" $ do
            isValidMove sampleBoard (Move (Pos 'c' 1) (Pos 'f' 4) 0) `shouldBe` (False :: Bool)

        it "15" $ do
            isValidMove sampleBoard (Move (Pos 'd' 3) (Pos 'd' 4) 0) `shouldBe` (False :: Bool) -- up not possible

        it "16" $ do
            isValidMove sampleBoard (Move (Pos 'e' 3) (Pos 'f' 4) 0) `shouldBe` (False :: Bool) -- up right not possible

        it "16" $ do
            isValidMove sampleBoard (Move (Pos 'e' 3) (Pos 'd' 4) 0) `shouldBe` (False :: Bool) -- up left not possible

        it "16" $ do
            isValidMove sampleBoard (Move (Pos 'e' 7) (Pos 'f' 6) 0) `shouldBe` (False :: Bool) -- down right not possible

        it "16" $ do
            isValidMove sampleBoard (Move (Pos 'e' 7) (Pos 'd' 6) 0) `shouldBe` (False :: Bool) -- down left not possible

        it "17" $ do
            isValidMove sampleBoard10 (Move (Pos 'd' 7) (Pos 'd' 6) 0) `shouldBe` (False :: Bool) -- down not possible

        it "18" $ do
            isValidMove sampleBoard10 (Move (Pos 'g' 2) (Pos 'h' 2) 0) `shouldBe` (False :: Bool) -- right not possible

        it "19" $ do
            isValidMove sampleBoard10 (Move (Pos 'g' 2) (Pos 'g' 3) 0) `shouldBe` (True :: Bool) -- up possible

        it "20" $ do
            isValidMove sampleBoard11 (Move (Pos 'g' 2) (Pos 'f' 3) 0) `shouldBe` (True :: Bool) -- up left possible

        it "21" $ do
            isValidMove sampleBoard (Move (Pos 'f' 8) (Pos 'g' 7) 0) `shouldBe` (True :: Bool) -- down right possible

        it "22" $ do
            isValidMove sampleBoard (Move (Pos 'h' 9) (Pos 'h' 8) 0) `shouldBe` (True :: Bool)

        it "23" $ do
            isValidMove sampleBoard (Move (Pos 'i' 9) (Pos 'i' 8) 0) `shouldBe` (False :: Bool)

        it "24" $ do
            isValidMove sampleBoard (Move (Pos 'b' 1) (Pos 'b' 2) 0) `shouldBe` (True :: Bool)

        it "24" $ do
            isValidMove sampleBoard (Move (Pos 'h' 9) (Pos 'i' 9) 0) `shouldBe` (True :: Bool)

        it "24" $ do
            isValidMove sampleBoard (Move (Pos 'a' 1) (Pos 'a' 2) 0) `shouldBe` (False :: Bool)

        it "24" $ do
            isValidMove sampleBoard20 (Move (Pos 'a' 1) (Pos 'a' 2) 0) `shouldBe` (False :: Bool) -- here

        it "25" $ do
            isValidMove sampleBoard20 (Move (Pos 'b' 1) (Pos 'c' 2) 0) `shouldBe` (False :: Bool) -- here

        it "24" $ do
            isValidMove sampleBoard20 (Move (Pos 'a' 1) (Pos 'a' 2) 0) `shouldBe` (False :: Bool)

        it "24" $ do
            isValidMove sampleBoard20 (Move (Pos 'a' 1) (Pos 'a' 2) 0) `shouldBe` (False :: Bool)

        it "24" $ do
            isValidMove sampleBoard20 (Move (Pos 'a' 1) (Pos 'a' 2) 0) `shouldBe` (False :: Bool)

        it "26" $ do
            isValidMove sampleBoard (Move (Pos 'd' 3) (Pos 'b' 3) 0) `shouldBe` (False :: Bool)

        it "26" $ do
            isValidMove sampleBoard300 (Move (Pos 'd' 1) (Pos 'a' 4) 0) `shouldBe` (False :: Bool)













testPossibleMoves :: Spec
testPossibleMoves = describe "Module Game: possibleMoves ..." $ do
        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 1) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 4) 0] :: [Move]) -- Shield up
        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 1) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 4) 1] :: [Move])
        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 1) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 4) 2] :: [Move]) -- Shield up
        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 1) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 4) 3] :: [Move])
        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 1) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 4) 4] :: [Move]) -- Shield up
        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 1) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 4) 5] :: [Move])
        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 1) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 4) 6] :: [Move]) -- Shield up
        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 1) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 4) 7] :: [Move])


        it "1" $ do
            possibleMoves (Pos 'd' 7) (Piece White 16) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 6) 0] :: [Move]) -- Shield down
        it "1" $ do
            possibleMoves (Pos 'd' 7) (Piece White 16) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 6) 1] :: [Move]) -- Shield down
        it "1" $ do
            possibleMoves (Pos 'd' 7) (Piece White 16) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 6) 2] :: [Move]) -- Shield down
        it "1" $ do
            possibleMoves (Pos 'd' 7) (Piece White 16) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 6) 3] :: [Move]) -- Shield down
        it "1" $ do
            possibleMoves (Pos 'd' 7) (Piece White 16) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 6) 4] :: [Move]) -- Shield down
        it "1" $ do
            possibleMoves (Pos 'd' 7) (Piece White 16) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 6) 5] :: [Move]) -- Shield down
        it "1" $ do
            possibleMoves (Pos 'd' 7) (Piece White 16) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 6) 6] :: [Move]) -- Shield down
        it "1" $ do
            possibleMoves (Pos 'd' 7) (Piece White 16) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 6) 7] :: [Move]) -- Shield down


        it "2" $ do
            possibleMoves (Pos 'd' 3) (Piece White 4) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 3) 0] :: [Move]) -- Shield right
        it "2" $ do
            possibleMoves (Pos 'd' 3) (Piece White 4) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 3) 1] :: [Move]) -- Shield right
        it "2" $ do
            possibleMoves (Pos 'd' 3) (Piece White 4) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 3) 2] :: [Move]) -- Shield right
        it "2" $ do
            possibleMoves (Pos 'd' 3) (Piece White 4) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 3) 3] :: [Move]) -- Shield right
        it "2" $ do
            possibleMoves (Pos 'd' 3) (Piece White 4) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 3) 4] :: [Move]) -- Shield right
        it "2" $ do
            possibleMoves (Pos 'd' 3) (Piece White 4) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 3) 5] :: [Move]) -- Shield right
        it "2" $ do
            possibleMoves (Pos 'd' 3) (Piece White 4) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 3) 6] :: [Move]) -- Shield right
        it "2" $ do
            possibleMoves (Pos 'd' 3) (Piece White 4) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 3) 7] :: [Move]) -- Shield right



        it "3" $ do
            possibleMoves (Pos 'd' 3) (Piece White 2) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 4) 1] :: [Move]) -- Shield up_right
        it "3" $ do
            possibleMoves (Pos 'd' 3) (Piece White 2) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 4) 0] :: [Move]) -- Shield up_right
        it "3" $ do
            possibleMoves (Pos 'd' 3) (Piece White 2) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 4) 2] :: [Move]) -- Shield up_right
        it "3" $ do
            possibleMoves (Pos 'd' 3) (Piece White 2) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 4) 3] :: [Move]) -- Shield up_right
        it "3" $ do
            possibleMoves (Pos 'd' 3) (Piece White 2) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 4) 4] :: [Move]) -- Shield up_right
        it "3" $ do
            possibleMoves (Pos 'd' 3) (Piece White 2) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 4) 5] :: [Move]) -- Shield up_right
        it "3" $ do
            possibleMoves (Pos 'd' 3) (Piece White 2) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 4) 6] :: [Move]) -- Shield up_right
        it "3" $ do
            possibleMoves (Pos 'd' 3) (Piece White 2) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 4) 7] :: [Move]) -- Shield up_right



        it "4" $ do
            possibleMoves (Pos 'd' 3) (Piece White 8) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 2) 0] :: [Move]) -- Shield down_right
        it "4" $ do
            possibleMoves (Pos 'd' 3) (Piece White 8) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 2) 1] :: [Move]) -- Shield down_right
        it "4" $ do
            possibleMoves (Pos 'd' 3) (Piece White 8) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 2) 2] :: [Move]) -- Shield down_right
        it "4" $ do
            possibleMoves (Pos 'd' 3) (Piece White 8) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 2) 3] :: [Move]) -- Shield down_right
        it "4" $ do
            possibleMoves (Pos 'd' 3) (Piece White 8) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 2) 4] :: [Move]) -- Shield down_right
        it "4" $ do
            possibleMoves (Pos 'd' 3) (Piece White 8) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 2) 5] :: [Move]) -- Shield down_right
        it "4" $ do
            possibleMoves (Pos 'd' 3) (Piece White 8) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 2) 6] :: [Move]) -- Shield down_right
        it "4" $ do
            possibleMoves (Pos 'd' 3) (Piece White 8) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 2) 7] :: [Move]) -- Shield down_right



        it "5" $ do
            possibleMoves (Pos 'd' 3) (Piece White 128) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 4) 0] :: [Move]) -- Shield up_left
        it "5" $ do
            possibleMoves (Pos 'd' 3) (Piece White 128) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 4) 1] :: [Move]) -- Shield up_left
        it "5" $ do
            possibleMoves (Pos 'd' 3) (Piece White 128) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 4) 2] :: [Move]) -- Shield up_left
        it "5" $ do
            possibleMoves (Pos 'd' 3) (Piece White 128) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 4) 3] :: [Move]) -- Shield up_left
        it "5" $ do
            possibleMoves (Pos 'd' 3) (Piece White 128) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 4) 4] :: [Move]) -- Shield up_left
        it "5" $ do
            possibleMoves (Pos 'd' 3) (Piece White 128) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 4) 5] :: [Move]) -- Shield up_left
        it "5" $ do
            possibleMoves (Pos 'd' 3) (Piece White 128) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 4) 6] :: [Move]) -- Shield up_left
        it "5" $ do
            possibleMoves (Pos 'd' 3) (Piece White 128) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 4) 7] :: [Move]) -- Shield up_left



        it "6" $ do
            possibleMoves (Pos 'd' 3) (Piece White 32) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 2) 0] :: [Move]) -- Shield down_left
        it "6" $ do
            possibleMoves (Pos 'd' 3) (Piece White 32) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 2) 1] :: [Move]) -- Shield down_left
        it "6" $ do
            possibleMoves (Pos 'd' 3) (Piece White 32) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 2) 2] :: [Move]) -- Shield down_left
        it "6" $ do
            possibleMoves (Pos 'd' 3) (Piece White 32) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 2) 3] :: [Move]) -- Shield down_left
        it "6" $ do
            possibleMoves (Pos 'd' 3) (Piece White 32) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 2) 4] :: [Move]) -- Shield down_left
        it "6" $ do
            possibleMoves (Pos 'd' 3) (Piece White 32) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 2) 5] :: [Move]) -- Shield down_left
        it "6" $ do
            possibleMoves (Pos 'd' 3) (Piece White 32) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 2) 6] :: [Move]) -- Shield down_left
        it "6" $ do
            possibleMoves (Pos 'd' 3) (Piece White 32) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 2) 7] :: [Move]) -- Shield down_left



        it "7" $ do
            possibleMoves (Pos 'd' 3) (Piece White 64) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 3) 0] :: [Move]) -- Shield left
        it "7" $ do
            possibleMoves (Pos 'd' 3) (Piece White 64) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 3) 1] :: [Move]) -- Shield left
        it "7" $ do
            possibleMoves (Pos 'd' 3) (Piece White 64) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 3) 2] :: [Move]) -- Shield left
        it "7" $ do
            possibleMoves (Pos 'd' 3) (Piece White 64) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 3) 3] :: [Move]) -- Shield left
        it "7" $ do
            possibleMoves (Pos 'd' 3) (Piece White 64) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 3) 4] :: [Move]) -- Shield left
        it "7" $ do
            possibleMoves (Pos 'd' 3) (Piece White 64) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 3) 5] :: [Move]) -- Shield left
        it "7" $ do
            possibleMoves (Pos 'd' 3) (Piece White 64) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 3) 6] :: [Move]) -- Shield left
        it "7" $ do
            possibleMoves (Pos 'd' 3) (Piece White 64) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 3) 7] :: [Move]) -- Shield left





        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 17) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 4) 0] :: [Move]) -- Probe up
        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 17) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 5) 0] :: [Move]) -- Probe up

        it "10" $ do
            possibleMoves (Pos 'd' 7) (Piece White 17) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 6) 0] :: [Move]) -- Probe down
        it "10" $ do
            possibleMoves (Pos 'd' 7) (Piece White 17) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 5) 0] :: [Move]) -- Probe down


        it "20" $ do
            possibleMoves (Pos 'd' 3) (Piece White 5) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 3) 0] :: [Move]) -- Probe right
        it "20" $ do
            possibleMoves (Pos 'd' 3) (Piece White 5) `shouldContain` ([Move (Pos 'd' 3) (Pos 'f' 3) 0] :: [Move]) -- Probe right

        it "30" $ do
            possibleMoves (Pos 'd' 3) (Piece White 130) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 4) 0] :: [Move]) -- Probe up_right
        it "30" $ do
            possibleMoves (Pos 'd' 3) (Piece White 130) `shouldContain` ([Move (Pos 'd' 3) (Pos 'f' 5) 0] :: [Move]) -- Probe up_right

        it "40" $ do
            possibleMoves (Pos 'd' 3) (Piece White 10) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 2) 0] :: [Move]) -- Probe down_right
        it "40" $ do
            possibleMoves (Pos 'd' 3) (Piece White 10) `shouldContain` ([Move (Pos 'd' 3) (Pos 'f' 1) 0] :: [Move]) -- Probe down_right

        it "50" $ do
            possibleMoves (Pos 'd' 3) (Piece White 130) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 4) 0] :: [Move]) -- Probe up_left
        it "50" $ do
            possibleMoves (Pos 'd' 3) (Piece White 130) `shouldContain` ([Move (Pos 'd' 3) (Pos 'b' 5) 0] :: [Move]) -- Probe up_left

        it "60" $ do
            possibleMoves (Pos 'd' 3) (Piece White 34) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 2) 0] :: [Move]) -- Probe down_left
        it "60" $ do
            possibleMoves (Pos 'd' 3) (Piece White 34) `shouldContain` ([Move (Pos 'd' 3) (Pos 'b' 1) 0] :: [Move]) -- Probe down_left

        it "70" $ do
            possibleMoves (Pos 'd' 3) (Piece White 68) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 3) 0] :: [Move]) -- Probe left
        it "70" $ do
            possibleMoves (Pos 'd' 3) (Piece White 68) `shouldContain` ([Move (Pos 'd' 3) (Pos 'b' 3) 0] :: [Move]) -- Probe left



        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 69) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 4) 0] :: [Move]) -- Lance up
        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 69) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 5) 0] :: [Move]) -- Lance up
        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 69) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 6) 0] :: [Move]) -- Lance up


        it "100" $ do
            possibleMoves (Pos 'd' 7) (Piece White 146) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 6) 0] :: [Move]) -- Lance down
        it "100" $ do
            possibleMoves (Pos 'd' 7) (Piece White 146) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 5) 0] :: [Move]) -- Lance down
        it "100" $ do
            possibleMoves (Pos 'd' 7) (Piece White 146) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 4) 0] :: [Move]) -- Lance down


        it "200" $ do
            possibleMoves (Pos 'd' 3) (Piece White 69) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 3) 0] :: [Move]) -- Lance right
        it "200" $ do
            possibleMoves (Pos 'd' 3) (Piece White 69) `shouldContain` ([Move (Pos 'd' 3) (Pos 'f' 3) 0] :: [Move]) -- Lance right
        it "200" $ do
            possibleMoves (Pos 'd' 3) (Piece White 69) `shouldContain` ([Move (Pos 'd' 3) (Pos 'g' 3) 0] :: [Move]) -- Lance right


        it "300" $ do
            possibleMoves (Pos 'd' 3) (Piece White 146) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 4) 0] :: [Move]) -- Lance up_right
        it "300" $ do
            possibleMoves (Pos 'd' 3) (Piece White 146) `shouldContain` ([Move (Pos 'd' 3) (Pos 'f' 5) 0] :: [Move]) -- Lance up_right
        it "300" $ do
            possibleMoves (Pos 'd' 3) (Piece White 146) `shouldContain` ([Move (Pos 'd' 3) (Pos 'g' 6) 0] :: [Move]) -- Lance up_right


        it "400" $ do
            possibleMoves (Pos 'd' 4) (Piece White 56) `shouldContain` ([Move (Pos 'd' 4) (Pos 'e' 3) 0] :: [Move]) -- Lance down_right
        it "400" $ do
            possibleMoves (Pos 'd' 4) (Piece White 56) `shouldContain` ([Move (Pos 'd' 4) (Pos 'f' 2) 0] :: [Move]) -- Lance down_right
        it "400" $ do
            possibleMoves (Pos 'd' 4) (Piece White 56) `shouldContain` ([Move (Pos 'd' 4) (Pos 'g' 1) 0] :: [Move]) -- Lance down_right

        it "400" $ do
            possibleMoves (Pos 'h' 4) (Piece White 56) `shouldContain` ([Move (Pos 'h' 4) (Pos 'i' 3) 0] :: [Move]) -- Lance down_right




        it "500" $ do
            possibleMoves (Pos 'd' 3) (Piece White 146) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 4) 0] :: [Move]) -- Lance up_left
        it "500" $ do
            possibleMoves (Pos 'd' 3) (Piece White 146) `shouldContain` ([Move (Pos 'd' 3) (Pos 'b' 5) 0] :: [Move]) -- Lance up_left
        it "500" $ do
            possibleMoves (Pos 'd' 3) (Piece White 146) `shouldContain` ([Move (Pos 'd' 3) (Pos 'a' 6) 0] :: [Move]) -- Lance up_left
        it "500" $ do
            possibleMoves (Pos 'i' 3) (Piece White 146) `shouldContain` ([Move (Pos 'i' 3) (Pos 'h' 4) 0] :: [Move]) -- Lance up_left


        it "600" $ do
            possibleMoves (Pos 'd' 4) (Piece White 56) `shouldContain` ([Move (Pos 'd' 4) (Pos 'c' 3) 0] :: [Move]) -- Lance down_left
        it "600" $ do
            possibleMoves (Pos 'd' 4) (Piece White 56) `shouldContain` ([Move (Pos 'd' 4) (Pos 'b' 2) 0] :: [Move]) -- Lance down_left
        it "600" $ do
            possibleMoves (Pos 'd' 4) (Piece White 56) `shouldContain` ([Move (Pos 'd' 4) (Pos 'a' 1) 0] :: [Move]) -- Lance down_left


        it "700" $ do
            possibleMoves (Pos 'd' 3) (Piece White 69) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 3) 0] :: [Move]) -- Lance left
        it "700" $ do
            possibleMoves (Pos 'd' 3) (Piece White 69) `shouldContain` ([Move (Pos 'd' 3) (Pos 'b' 3) 0] :: [Move]) -- Lance left
        it "700" $ do
            possibleMoves (Pos 'd' 3) (Piece White 69) `shouldContain` ([Move (Pos 'd' 3) (Pos 'a' 3) 0] :: [Move]) -- Lance left



        it "move shield one step" $ do
            possibleMoves (Pos 'd' 3) (Piece White 85) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 4) 0] :: [Move]) -- Commander up
        it "100" $ do
            possibleMoves (Pos 'd' 7) (Piece White 85) `shouldContain` ([Move (Pos 'd' 7) (Pos 'd' 6) 0] :: [Move]) -- Commander down
        it "200" $ do
            possibleMoves (Pos 'd' 3) (Piece White 85) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 3) 0] :: [Move]) -- Commander right
        it "300" $ do
            possibleMoves (Pos 'd' 3) (Piece White 170) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 4) 0] :: [Move]) -- Commander up_right
        it "400" $ do
            possibleMoves (Pos 'd' 3) (Piece White 170) `shouldContain` ([Move (Pos 'd' 3) (Pos 'e' 2) 0] :: [Move]) -- Commander down_right
        it "500" $ do
            possibleMoves (Pos 'd' 3) (Piece White 170) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 4) 0] :: [Move]) -- Commander up_left
        it "600" $ do
            possibleMoves (Pos 'd' 3) (Piece White 170) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 2) 0] :: [Move]) -- Commander down_left
        it "700" $ do
            possibleMoves (Pos 'd' 3) (Piece White 85) `shouldContain` ([Move (Pos 'd' 3) (Pos 'c' 3) 0] :: [Move]) -- Commander left




        it "700" $ do
            possibleMoves (Pos 'd' 3) (Piece White 85) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 3) 1] :: [Move]) -- Commander turn

        it "700" $ do
            possibleMoves (Pos 'd' 3) (Piece White 85) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 3) 2] :: [Move]) -- Commander turn

        it "700" $ do
            possibleMoves (Pos 'd' 3) (Piece White 85) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 3) 3] :: [Move]) -- Commander turn

        it "700" $ do
            possibleMoves (Pos 'd' 3) (Piece White 85) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 3) 4] :: [Move]) -- Commander turn

        it "700" $ do
            possibleMoves (Pos 'd' 3) (Piece White 85) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 3) 5] :: [Move]) -- Commander turn

        it "700" $ do
            possibleMoves (Pos 'd' 3) (Piece White 85) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 3) 6] :: [Move]) -- Commander turn
        it "700" $ do
            possibleMoves (Pos 'd' 3) (Piece White 85) `shouldContain` ([Move (Pos 'd' 3) (Pos 'd' 3) 7] :: [Move]) -- Commander turn






testListMoves :: Spec
testListMoves = describe "Module Game: listMoves ..." $ do
        it "game finished" $ do
            listMoves sampleBoard Black `shouldBe` ([] :: [Move])
        it "game finished" $ do
            listMoves sampleBoard_list_1 White `shouldBe` ([(Move (Pos 'a' 1) (Pos 'a' 1) 1),(Move (Pos 'a' 1) (Pos 'a' 1) 2),(Move (Pos 'a' 1) (Pos 'a' 1) 3),(Move (Pos 'a' 1) (Pos 'a' 1) 4),(Move (Pos 'a' 1) (Pos 'a' 1) 5),(Move (Pos 'a' 1) (Pos 'a' 1) 6),(Move (Pos 'a' 1) (Pos 'a' 1) 7),(Move (Pos 'a' 1) (Pos 'b' 2) 0),(Move (Pos 'f' 1) (Pos 'f' 1) 1),(Move (Pos 'f' 1) (Pos 'f' 1) 2),(Move (Pos 'f' 1) (Pos 'f' 1) 3),(Move (Pos 'f' 1) (Pos 'f' 1) 4),(Move (Pos 'f' 1) (Pos 'f' 1) 5),(Move (Pos 'f' 1) (Pos 'f' 1) 6),(Move (Pos 'f' 1) (Pos 'f' 1) 7),(Move (Pos 'f' 1) (Pos 'f' 2) 0),(Move (Pos 'f' 1) (Pos 'f' 3) 0),(Move (Pos 'f' 1) (Pos 'g' 2) 0),(Move (Pos 'f' 1) (Pos 'h' 3) 0)]:: [Move])

        it "1" $ do
            listMoves sampleBoard_list White `shouldContain` ([Move (Pos 'c' 8) (Pos 'c' 6) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list White `shouldContain` ( [Move (Pos 'f' 8) (Pos 'h' 6) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list White `shouldContain` ( [Move (Pos 'e' 7) (Pos 'e' 7) 4] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list White `shouldContain` ( [Move (Pos 'e' 7) (Pos 'e' 6) 3] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list White `shouldContain` ( [Move (Pos 'f' 1) (Pos 'f' 1) 4] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list White `shouldContain` ( [Move (Pos 'g' 9) (Pos 'g' 9) 2] :: [Move])






        it "1" $ do
            listMoves sampleBoard_list_2 White `shouldContain` ( [Move (Pos 'i' 1) (Pos 'i' 2) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_2 White `shouldContain` ( [Move (Pos 'h' 1) (Pos 'h' 2) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_2 White `shouldContain` ( [Move (Pos 'g' 1) (Pos 'g' 2) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_2 White `shouldContain` ( [Move (Pos 'f' 1) (Pos 'f' 2) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_2 White `shouldContain` ( [Move (Pos 'e' 1) (Pos 'e' 2) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_2 White `shouldContain` ( [Move (Pos 'd' 1) (Pos 'd' 2) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_2 White `shouldContain` ( [Move (Pos 'c' 1) (Pos 'c' 2) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_2 White `shouldContain` ( [Move (Pos 'b' 1) (Pos 'b' 2) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_2 White `shouldContain` ( [Move (Pos 'a' 1) (Pos 'a' 2) 0] :: [Move])




        it "1" $ do
            listMoves sampleBoard_list_3 White `shouldContain` ( [Move (Pos 'i' 2) (Pos 'i' 3) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_3 White `shouldContain` ( [Move (Pos 'h' 2) (Pos 'h' 3) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_3 White `shouldContain` ( [Move (Pos 'g' 2) (Pos 'g' 3) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_3 White `shouldContain` ( [Move (Pos 'f' 2) (Pos 'f' 3) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_3 White `shouldContain` ( [Move (Pos 'e' 2) (Pos 'e' 3) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_3 White `shouldContain` ( [Move (Pos 'd' 2) (Pos 'd' 3) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_3 White `shouldContain` ( [Move (Pos 'c' 2) (Pos 'c' 3) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_3 White `shouldContain` ( [Move (Pos 'b' 2) (Pos 'b' 3) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_3 White `shouldContain` ( [Move (Pos 'a' 2) (Pos 'a' 3) 0] :: [Move])


        it "1" $ do
            listMoves sampleBoard_list_4 White `shouldContain` ( [Move (Pos 'i' 3) (Pos 'i' 4) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_4 White `shouldContain` ( [Move (Pos 'h' 3) (Pos 'h' 4) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_4 White `shouldContain` ( [Move (Pos 'g' 3) (Pos 'g' 4) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_4 White `shouldContain` ( [Move (Pos 'f' 3) (Pos 'f' 4) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_4 White `shouldContain` ( [Move (Pos 'e' 3) (Pos 'e' 4) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_4 White `shouldContain` ( [Move (Pos 'd' 3) (Pos 'd' 4) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_4 White `shouldContain` ( [Move (Pos 'c' 3) (Pos 'c' 4) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_4 White `shouldContain` ( [Move (Pos 'b' 3) (Pos 'b' 4) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_4 White `shouldContain` ( [Move (Pos 'a' 3) (Pos 'a' 4) 0] :: [Move])




        it "1" $ do
            listMoves sampleBoard_list_5 White `shouldContain` ( [Move (Pos 'i' 4) (Pos 'i' 5) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_5 White `shouldContain` ( [Move (Pos 'h' 4) (Pos 'h' 5) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_5 White `shouldContain` ( [Move (Pos 'g' 4) (Pos 'g' 5) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_5 White `shouldContain` ( [Move (Pos 'f' 4) (Pos 'f' 5) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_5 White `shouldContain` ( [Move (Pos 'e' 4) (Pos 'e' 5) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_5 White `shouldContain` ( [Move (Pos 'd' 4) (Pos 'd' 5) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_5 White `shouldContain` ( [Move (Pos 'c' 4) (Pos 'c' 5) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_5 White `shouldContain` ( [Move (Pos 'b' 4) (Pos 'b' 5) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_5 White `shouldContain` ( [Move (Pos 'a' 4) (Pos 'a' 5) 0] :: [Move])



        it "1" $ do
            listMoves sampleBoard_list_6 White `shouldContain` ( [Move (Pos 'i' 5) (Pos 'i' 6) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_6 White `shouldContain` ( [Move (Pos 'h' 5) (Pos 'h' 6) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_6 White `shouldContain` ( [Move (Pos 'g' 5) (Pos 'g' 6) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_6 White `shouldContain` ( [Move (Pos 'f' 5) (Pos 'f' 6) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_6 White `shouldContain` ( [Move (Pos 'e' 5) (Pos 'e' 6) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_6 White `shouldContain` ( [Move (Pos 'd' 5) (Pos 'd' 6) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_6 White `shouldContain` ( [Move (Pos 'c' 5) (Pos 'c' 6) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_6 White `shouldContain` ( [Move (Pos 'b' 5) (Pos 'b' 6) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_6 White `shouldContain` ( [Move (Pos 'a' 5) (Pos 'a' 6) 0] :: [Move])



        it "1" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'i' 6) (Pos 'i' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'h' 6) (Pos 'h' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'g' 6) (Pos 'g' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'f' 6) (Pos 'f' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'e' 6) (Pos 'e' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'd' 6) (Pos 'd' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'c' 6) (Pos 'c' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'b' 6) (Pos 'b' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'a' 6) (Pos 'a' 7) 0] :: [Move])



        it "1" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'i' 6) (Pos 'i' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'h' 6) (Pos 'h' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'g' 6) (Pos 'g' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'f' 6) (Pos 'f' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'e' 6) (Pos 'e' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'd' 6) (Pos 'd' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'c' 6) (Pos 'c' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'b' 6) (Pos 'b' 7) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_7 White `shouldContain` ( [Move (Pos 'a' 6) (Pos 'a' 7) 0] :: [Move])




        it "1" $ do
            listMoves sampleBoard_list_8 White `shouldContain` ( [Move (Pos 'i' 7) (Pos 'i' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_8 White `shouldContain` ( [Move (Pos 'h' 7) (Pos 'h' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_8 White `shouldContain` ( [Move (Pos 'g' 7) (Pos 'g' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_8 White `shouldContain` ( [Move (Pos 'f' 7) (Pos 'f' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_8 White `shouldContain` ( [Move (Pos 'e' 7) (Pos 'e' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_8 White `shouldContain` ( [Move (Pos 'd' 7) (Pos 'd' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_8 White `shouldContain` ( [Move (Pos 'c' 7) (Pos 'c' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_8 White `shouldContain` ( [Move (Pos 'b' 7) (Pos 'b' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_8 White `shouldContain` ( [Move (Pos 'a' 7) (Pos 'a' 8) 0] :: [Move])


        it "1" $ do
            listMoves sampleBoard_list_9 White `shouldContain` ( [Move (Pos 'i' 8) (Pos 'i' 9) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_9 White `shouldContain` ( [Move (Pos 'h' 8) (Pos 'h' 9) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_9 White `shouldContain` ( [Move (Pos 'g' 8) (Pos 'g' 9) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_9 White `shouldContain` ( [Move (Pos 'f' 8) (Pos 'f' 9) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_9 White `shouldContain` ( [Move (Pos 'e' 8) (Pos 'e' 9) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_9 White `shouldContain` ( [Move (Pos 'd' 8) (Pos 'd' 9) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_9 White `shouldContain` ( [Move (Pos 'c' 8) (Pos 'c' 9) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_9 White `shouldContain` ( [Move (Pos 'b' 8) (Pos 'b' 9) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_9 White `shouldContain` ( [Move (Pos 'a' 8) (Pos 'a' 9) 0] :: [Move])


        it "1" $ do
            listMoves sampleBoard_list_10 White `shouldContain` ( [Move (Pos 'i' 9) (Pos 'i' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_10 White `shouldContain` ( [Move (Pos 'h' 9) (Pos 'h' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_10 White `shouldContain` ( [Move (Pos 'g' 9) (Pos 'g' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_10 White `shouldContain` ( [Move (Pos 'f' 9) (Pos 'f' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_10 White `shouldContain` ( [Move (Pos 'e' 9) (Pos 'e' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_10 White `shouldContain` ( [Move (Pos 'd' 9) (Pos 'd' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_10 White `shouldContain` ( [Move (Pos 'c' 9) (Pos 'c' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_10 White `shouldContain` ( [Move (Pos 'b' 9) (Pos 'b' 8) 0] :: [Move])
        it "2" $ do
            listMoves sampleBoard_list_10 White `shouldContain` ( [Move (Pos 'a' 9) (Pos 'a' 8) 0] :: [Move])

        it "2" $ do
            listMoves sampleBoard1000 Black `shouldContain` ( [Move (Pos 'g' 2) (Pos 'g' 3) 0] :: [Move])







       
