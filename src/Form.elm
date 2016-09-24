module Form exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Set
import Field exposing (..)
import Fixtures exposing (..)

type alias Model = List (List Field)

initModel =
  [billingTest] ++ extraTest

-- update
type Msg
  = UpdateField String String

update msg model =
  case msg of
    UpdateField name value ->
      let updateField id field =
          if field.name == name then { field | value  = value }
          else                         field
      in
        List.map (List.indexedMap updateField) model

-- view
view model =
  let
    billingFields   = model |> List.take 1
    repeatingFields = model |> List.drop 1
  in
    Html.form []
      [ div [] (List.map fieldGroupView billingFields)
      , div [] (List.map fieldGroupView repeatingFields)
      ]


fieldGroupView fields =
  let first = List.head fields
      repeatingIndex = (Maybe.andThen first .repeatingIndex)
      fieldGroupHeading' = fieldGroupHeading repeatingIndex
  in
    div []
      [ h2 [] [text fieldGroupHeading']
      , div [] (List.map fieldView fields)
      ]

fieldGroupHeading repeatingIndex =
  case repeatingIndex of
    Just n ->
      "Deelnemer " ++ toString n
    Nothing ->
      "Billing"

fieldView field =
  div [class "form-input"]
    [ label [for field.name] [text field.label]
    , input
      [ name field.name
      , id field.name
      , placeholder field.placeholder
      , onInput (UpdateField field.name)
      ] []
    ]

billing field =
  case field.repeatingIndex of
    Nothing -> True
    _       -> False

groupSize fields =
    let
      nameAtttrs = List.map .name fields
    in
      nameAtttrs
      |> Set.fromList
      |> Set.toList
      |> List.length
