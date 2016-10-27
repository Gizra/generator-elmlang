module App.Test exposing (all)

import Test exposing (..)
import Expect
import RemoteData exposing (RemoteData(..))
import App.Model exposing (..)
import App.Update exposing (..)


setActivePage : Test
setActivePage =
    describe "SetActivePage msg"
        [ test "set new active page" <|
            \() ->
                Expect.equal PageNotFound (getPageAsAnonymous PageNotFound)
        , test "set Login page for anonymous user" <|
            \() ->
                Expect.equal Login (getPageAsAnonymous Login)
        , test "set My account page for anonymous user" <|
            \() ->
                Expect.equal AccessDenied (getPageAsAnonymous MyAccount)
        , test "set Login page for authenticated user" <|
            \() ->
                Expect.equal AccessDenied (getPageAsAuthenticated Login)
        , test "set My account page for authenticated user" <|
            \() ->
                Expect.equal MyAccount (getPageAsAuthenticated MyAccount)
        ]


getPageAsAnonymous : Page -> Page
getPageAsAnonymous page =
    update (SetActivePage page) emptyModel
        |> fst
        |> .activePage


getPageAsAuthenticated : Page -> Page
getPageAsAuthenticated page =
    let
        dummyUser =
            { name = Just "Foo", login = "foo", avatarUrl = "https://example.com" }

        model =
            { emptyModel | user = Success dummyUser }
    in
        update (SetActivePage page) model
            |> fst
            |> .activePage


all : Test
all =
    describe "App tests"
        [ setActivePage
        ]
