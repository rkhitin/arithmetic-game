module Main exposing (Model, Msg(..), Question, Result(..), init, main, questions, subscriptions, update, view)

import Browser exposing (Document)
import Html exposing (..)
import List exposing (foldr, indexedMap, repeat)


type alias Question =
    { numbers : List (List Int), operations : List String, answers : List Int }


type Result
    = Right
    | Wrong
    | Blank


questions : List Question
questions =
    [ { numbers = [ [ 3, 5 ], [ 6 ] ]
      , operations = [ "+", "*" ]
      , answers = [ 12, 48, 5, 6 ]
      }
    , { numbers = [ [ 3 ], [ 5 ], [ 6 ] ]
      , operations = [ "+", "-" ]
      , answers = [ 12, 4, 5, 2 ]
      }
    ]



-- Model


type alias Model =
    { results : List Result
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { results = List.repeat 10 Blank }, Cmd.none )



-- Update


type Msg
    = PickAnswer Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PickAnswer answeredNumber ->
            ( model, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- View


view : Model -> Document Msg
view model =
    { title = "Hello"
    , body = [ div [] [ model.results |> getCurrentStep |> String.fromInt |> text ] ]
    }



-- Main


main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Helpers


addIndex results =
    indexedMap (\index result -> ( index, result )) results


getFirstBlankIndex resultsWithIndex =
    Tuple.first
        (foldr
            (\r resultWithIndex ->
                if Tuple.second resultWithIndex /= Blank then
                    resultWithIndex

                else
                    r
            )
            ( 0, Blank )
            resultsWithIndex
        )


getCurrentStep results =
    results |> addIndex |> getFirstBlankIndex
