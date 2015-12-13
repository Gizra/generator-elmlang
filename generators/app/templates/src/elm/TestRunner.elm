module Main where

import Graphics.Element exposing (Element)

import ElmTest exposing (..)

import CounterTest exposing (all)

allTests : Test
allTests =
  suite "All tests"
    [ CounterTest.all
    ]

main : Element
main =
  elementRunner allTests
