module Main exposing (main)

import Browser exposing (element)
import Html exposing (..)
import Html.Attributes exposing (class)
import Http exposing (Error)
import Loading exposing (httpGet, viewLoader, waitMs)
import Task exposing (perform)


type Msg
    = IsTakingTooLong
    | Completed


type Model
    = Wait
    | Show
    | Done


requestHandler : Result Http.Error String -> Msg
requestHandler expect =
    case expect of
        Err message ->
            IsTakingTooLong

        Ok st ->
            IsTakingTooLong



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IsTakingTooLong ->
            ( Show, perform (\_ -> Completed) (waitMs 4500) )

        Completed ->
            ( Done, Cmd.none )



-- INIT


init : String -> ( Model, Cmd Msg )
init _ =
    ( Wait, perform (\_ -> IsTakingTooLong) (waitMs 600) )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    case model of
        Wait ->
            text "Waiting for loading to take more than 500ms"

        Show ->
            viewLoader

        Done ->
            text "Loading complete"



-- MAIN


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
