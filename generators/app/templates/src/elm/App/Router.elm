module App.Router exposing (delta2url, location2messages)

import App.Model exposing (..)
import App.Update exposing (..)
import Navigation exposing (Location)
import RouteUrl exposing (HistoryEntry(..), UrlChange)


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    case current.activePage of
        Counter ->
            Just <| UrlChange NewEntry "/#counter"

        PageNotFound ->
            Just <| UrlChange NewEntry "/#404"


location2messages : Location -> List Msg
location2messages location =
    case location.hash of
        "" ->
            []

        "#counter" ->
            [ SetActivePage Counter ]

        "#404" ->
            [ SetActivePage PageNotFound ]

        _ ->
            [ SetActivePage PageNotFound ]
