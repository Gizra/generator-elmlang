module Main exposing (..)

import ElmTest exposing (..)
import Pages.Counter.Test as Counter exposing (all)


allTests : Test
allTests =
    suite "All tests"
        [ Counter.all
        ]


main : Program Never
main =
    runSuiteHtml allTests
