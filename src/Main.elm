module Main exposing (main)

import Browser exposing (element)
import Html exposing (..)
import Html.Attributes exposing (class)
import Loading exposing (waitMs)
import Task exposing (perform)


type Msg
    = IsTakingTooLong ()
    | Completed ()


type LoadingIndicator
    = Wait
    | Show
    | Done


type alias Model =
    { showLoader : LoadingIndicator }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IsTakingTooLong () ->
            ( { model | showLoader = Show }, perform Completed (waitMs 4500) )

        Completed () ->
            ( { model | showLoader = Done }, Cmd.none )



-- INIT


init : String -> ( Model, Cmd Msg )
init _ =
    ( { showLoader = Wait }, perform IsTakingTooLong (waitMs 500) )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


viewLoader : Html Msg
viewLoader =
    div [ class "lds-ripple" ]
        [ div [] []
        , div [] []
        ]


view : Model -> Html Msg
view model =
    case model.showLoader of
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
