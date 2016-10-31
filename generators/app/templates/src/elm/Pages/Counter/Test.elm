module Pages.Counter.Test exposing (..)

import Test exposing (..)
import Expect
import Pages.Counter.Model as Counter exposing (emptyModel, Model)
import Pages.Counter.Update as Counter exposing (..)


decrementActionSuite : Test
decrementActionSuite =
    describe "Decrement action"
        [ test "negative count" <|
            \() ->
                Expect.equal -2 (updateCounter Counter.Decrement -1)
        , test "zero count" <|
            \() ->
                Expect.equal -1 (updateCounter Counter.Decrement 0)
        , test "positive count" <|
            \() ->
                Expect.equal 0 (updateCounter Counter.Decrement 1)
        ]


incrementActionSuite : Test
incrementActionSuite =
    describe "Increment action"
        [ test "negative count" <|
            \() ->
                Expect.equal 0 (updateCounter Counter.Increment -1)
        , test "zero count" <|
            \() ->
                Expect.equal 1 (updateCounter Counter.Increment 0)
        , test "positive count" <|
            \() ->
                Expect.equal 2 (updateCounter Counter.Increment 1)
        ]


updateCounter : Counter.Msg -> Int -> Counter.Model
updateCounter action initialModel =
    fst <| Counter.update action initialModel


all : Test
all =
    describe "Counter tests"
        [ decrementActionSuite
        , incrementActionSuite
        ]
