module Main where

import ElmTest exposing (..)
import Graphics.Element exposing (Element)

import CounterTest exposing (all)

allTests : Test
allTests =
  suite "All tests"
    [ CounterTest.all
    ]

main : Element
main =
  elementRunner allTests
