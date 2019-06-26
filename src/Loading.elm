module Loading exposing (httpGet, viewLoader, waitMs)

import Html exposing (..)
import Html.Attributes exposing (class)
import Http exposing (..)
import Process exposing (..)
import Task exposing (Task)


waitMs : Float -> Task Never ()
waitMs delay =
    Process.sleep delay


httpGet : (Result Error String -> msg) -> Cmd msg
httpGet handler =
    Http.get
        { url = "https://www.google.it"
        , expect = Http.expectString handler
        }


viewLoader : Html msg
viewLoader =
    div [ class "lds-ripple" ]
        [ div [] []
        , div [] []
        ]
