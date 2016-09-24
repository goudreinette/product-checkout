module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Form

main =
  App.program
    { init = init
    , update = update
    , view = view
    , subscriptions =  \_ -> Sub.none
    }

-- model


type alias Model =
  { form : Form.Model
  , qty : Int
  , maxQty : Int
  , cost : Float
  }

init =
  Model Form.initModel 1 5 35  ! []

-- update

type Msg
  = NoOp
  | ChangeQuantity Int
  | FormMsg Form.Msg

update msg model =
  case msg of
    FormMsg msg ->
      { model | form = (Form.update msg model.form)} ! []
    _ ->
      model ! []


-- view
view model =
  div [class "container"]
    [ topView model
    , bottomView model
    ]

topView model =
  div [class "top"]
    [ div [class "product"] []
    , quantityView model.qty
    ]

quantityView quantity =
  div [class "quantity"]
    [ --  button [] [text "+"]
     input
        [ value <| toString quantity
        , type' "number"
        ]
        []
    -- , button [] [text "-"]
    ]

bottomView model =
  div [class "bottom"]
    [ (App.map FormMsg (Form.view model.form))
    , div [class "review"] [ div [class "inner"] [] ]
    ]
