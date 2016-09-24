module Fixtures exposing (..)
import Field exposing (..)

billingTest : List Field
billingTest =
  [ field "Name" "name" "..." []
  , field "Email" "email" "..." []
  , field "Address" "address" "..." []
  , field "Order Notes" "order_notes" "..." []
  ]


extraTest : List (List Field)
extraTest =
  let fields =
    [ field "Name" "name" "..." []
    , field "Address" "address" "..." []
    , field "Pet" "pet" "..." []
    ]
  in
    repeat 2 fields
