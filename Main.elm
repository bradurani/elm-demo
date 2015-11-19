import Mouse exposing (..)
import Html exposing (..)
import Signal exposing (..)

main = text << toString <~ Mouse.position
