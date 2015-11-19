import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Array exposing (..)

type Piece = Red | Black | Empty
type alias Board = Array (Array Piece)



width = 7
height = 6

padding = 20
pieceSize = 40

boardHeight = 700
boardWidth = 816

availableHeight : Int
availableHeight = boardHeight - (2 * padding) - 2 * pieceSize

availableWidth : Int
availableWidth = boardWidth - (2 * padding) - 2 * pieceSize

blankBoard : Board
blankBoard = Array.repeat height (Array.repeat width Empty)

--no loops, so nested functions
pieces : Board -> List Form
pieces board =
  let formBoard = toList board |> List.indexedMap (\rowNum row -> 
                    toList row |> List.indexedMap (\colNum piece -> 
                      drawPiece piece rowNum colNum 
                    )
                  )
  in
    formBoard |> List.concatMap identity

drawPiece : Piece -> Int -> Int -> Form
drawPiece piece row column =
  let color = case piece of
                Red -> Color.red
                Black -> Color.black
                Empty -> Color.white
  in drawCircle color row column

-- Draw Circles --
drawCircle : Color -> Int -> Int -> Form
drawCircle color row column = 
  let coords = translate column row
      floatCoords = (toFloat (fst coords), toFloat (snd coords))
  in
  circle pieceSize |> filled color |> move floatCoords

translate : Int -> Int -> (Int,Int)
translate column row =
    (translateX column,translateY row)

translateX : Int -> Int
translateX column = 
  let startLeft = -(availableWidth // 2)
      gap = availableWidth // (width - 1)
  in 
  startLeft + (column * gap)

translateY : Int -> Int
translateY row = 
  let startTop = availableHeight // 2
      gap = availableHeight // (height - 1)
  in
  startTop - (row * gap)

bg : Form
bg = 
  rect (toFloat boardWidth) (toFloat boardHeight) |> filled blue

main = collage boardWidth boardHeight ([bg] ++ (pieces blankBoard))
