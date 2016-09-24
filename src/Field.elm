module Field exposing (..)

type ValidationRule
  = Email
  | Number
  | Required

type ValidationStatus
  = Normal
  | Valid
  | Invalid

type alias Field =
  { label : String
  , name : String
  , value : String
  , placeholder : String
  , validationRules : List ValidationRule
  , validationStatus : ValidationStatus
  , repeatingIndex : Maybe Int
  }

field l n p vr =
  Field l n "" p vr Normal Nothing


repeat times fields =
  List.repeat times fields
  |> List.indexedMap setIndex

setIndex n fields =
  let inner field =
    { field | repeatingIndex = Just (n + 1)}
  in
    List.map inner fields
