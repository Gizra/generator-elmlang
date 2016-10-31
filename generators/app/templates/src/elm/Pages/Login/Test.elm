module Pages.Login.Test exposing (all)

import Test exposing (..)
import Expect
import RemoteData exposing (RemoteData(..), WebData)
import Pages.Login.Model exposing (..)
import Pages.Login.Update exposing (..)
import User.Model exposing (..)


setLogin : Test
setLogin =
    describe "SetLogin msg"
        [ test "set name without spaces" <|
            \() ->
                Expect.equal "noSpaces" (getLogin "noSpaces")
        , test "set name with space" <|
            \() ->
                Expect.equal "withSpaces" (getLogin "with Spaces")
        , test "set name with multiple spaces" <|
            \() ->
                Expect.equal "withSpaces" (getLogin "  with   Spaces  ")
        , test "set name should result with NotAsked user status if name changed" <|
            \() ->
                Expect.equal NotAsked (getUserStatusAfterSetLogin Loading "someName" emptyModel)
        , test "set name should result with existing user status if name didn't change" <|
            \() ->
                Expect.equal Loading (getUserStatusAfterSetLogin Loading "  someName  " { login = "someName" })
        ]


dummyUser : User
dummyUser =
    { name = Just "Foo", login = "foo", avatarUrl = "https://example.com" }


getLogin : String -> String
getLogin login =
    let
        ( model, _, _ ) =
            update "https://example.com" NotAsked (SetLogin login) emptyModel
    in
        model.login


getUserStatusAfterSetLogin : WebData User -> String -> Model -> WebData User
getUserStatusAfterSetLogin user login model =
    let
        ( _, _, user ) =
            update "https://example.com" user (SetLogin login) model
    in
        user



{- Test the returned status after TryLogin msg. -}


tryLogin : Test
tryLogin =
    describe "TryLogin msg"
        [ test "Fetch empty name" <|
            \() ->
                Expect.equal NotAsked (getTryLogin NotAsked { login = "" })
        ]


getTryLogin : WebData User -> Model -> WebData User
getTryLogin user model =
    let
        ( _, _, userStatus ) =
            update "https://example.com" user TryLogin model
    in
        userStatus


all : Test
all =
    describe "Pages.Login tests"
        [ setLogin
        , tryLogin
        ]
