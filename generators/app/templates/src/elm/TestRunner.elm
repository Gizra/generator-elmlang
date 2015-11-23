module Main where

import CounterTest
import ElmTest.Test exposing (Test, suite)
import ElmTest.Runner.Element exposing (runDisplay)
import Graphics.Element exposing (Element)

import CounterTest exposing (all)

allTests : Test
allTests =
  suite "All tests"
    [ CounterTest.all
    ]

main : Element
main =
  runDisplay allTests
