module Main exposing (..)

import App.Test as App exposing (..)
import Pages.Counter.Test as Counter exposing (..)
import Pages.Login.Test as Login exposing (..)
import Test exposing (..)
import Test.Runner.Html


main : Program Never
main =
    [ App.all
    , Counter.all
    , Login.all
    ]
        |> concat
        |> Test.Runner.Html.run
