module CounterTest where

import ElmTest.Assertion exposing (..)
import ElmTest.Test exposing (..)

import Counter exposing (initialModel, UpdateContext)
import Effects exposing (Effects)

decrementActionSuite : Test
decrementActionSuite =
  suite "Decerment action"
    [ test "negative count" (assertEqual -2 (updateCounter Count.Increment -1))
    , test "zero count" (assertEqual -1 (updateCounter Count.Increment 0))
    , test "positive count" (assertEqual 1 (updateCounter Count.Increment 1))
    ]

incrementActionSuite : Test
incrementActionSuite =
  suite "Incerment action"
    [ test "negative count" (assertEqual 0 (updateCounter Count.Increment -1))
    , test "zero count" (assertEqual 1 (updateCounter Count.Increment 0))
    , test "positive count" (assertEqual 2 (updateCounter Count.Increment 1))
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
