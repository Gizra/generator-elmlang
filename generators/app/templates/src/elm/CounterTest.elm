module CounterTest where

import ElmTest exposing (..)

import Counter exposing (initialModel, UpdateContext)

decrementActionSuite : Test
decrementActionSuite =
  suite "Decerment action"
    [ test "negative count" (assertEqual -2 (updateCounter Counter.Decrement -1))
    , test "zero count" (assertEqual -1 (updateCounter Counter.Decrement 0))
    , test "positive count" (assertEqual 0 (updateCounter Counter.Decrement 1))
    ]

incrementActionSuite : Test
incrementActionSuite =
  suite "Incerment action"
    [ test "negative count" (assertEqual 0 (updateCounter Counter.Increment -1))
    , test "zero count" (assertEqual 1 (updateCounter Counter.Increment 0))
    , test "positive count" (assertEqual 2 (updateCounter Counter.Increment 1))
    ]

updateCounter : Counter.Action -> Int -> Counter.Model
updateCounter action initialModel =
  fst <| Counter.update action initialModel


all : Test
all =
  suite "Counter tests"
    [ decrementActionSuite
    , incrementActionSuite
    ]
