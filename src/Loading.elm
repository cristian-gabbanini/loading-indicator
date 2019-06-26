module Loading exposing (waitMs)

import Process exposing (..)
import Task exposing (Task)


waitMs : Float -> Task Never ()
waitMs delay =
    Process.sleep delay
