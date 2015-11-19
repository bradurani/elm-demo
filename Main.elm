import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)

width = 7
height = 6

boardHeight = 700
boardWidth = boardHeight * (width // height)

bg = 
  rect (toFloat boardWidth) (toFloat boardHeight) |> filled blue

main = collage boardWidth boardHeight [bg]
