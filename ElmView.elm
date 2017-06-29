port module ElmView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { value : String
  -- , output : String
  -- , displayValue : String
  }

init : (Model, Cmd Msg)
init =
  (Model "", Cmd.none)


-- UPDATE

type Msg
  = Change String
  | Check
  | Suggest String


port check : String -> Cmd msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Change s ->
      ( { model | value = s}, Cmd.none )
    Check ->
      ( model, check model.value )
    Suggest s ->
      ( model, Cmd.none ) 

-- SUBSCRIPTIONS

port suggestions : (String -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  suggestions Suggest


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ onInput Change] []
    , button [ onClick Check ] [ text "Send to Backbone" ]
    , div [] [ text (model.value) ]
    ]