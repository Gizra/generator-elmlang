module App.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, href, src, style, target)
import Html.App as Html
import Html.Events exposing (onClick)
import App.Model exposing (..)
import App.Update exposing (..)
import Pages.Counter.View exposing (..)
import Pages.PageNotFound.View exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div [ class "ui container main" ]
            [ viewHeader model
            , viewMainContent model
            , pre [ class "ui padded secondary segment" ]
                [ div [] [ text <| "activePage: " ++ toString model.activePage ]
                , div [] [ text <| "pageCounter: " ++ toString model.pageCounter ]
                ]
            ]
        , viewFooter
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    div [ class "ui secondary pointing menu" ] (navbarAnonymous model)


navbarAnonymous : Model -> List (Html Msg)
navbarAnonymous model =
    [ a
        [ classByPage Counter model.activePage
        , onClick <| SetActivePage Counter
        ]
        [ text "Counter" ]
    , viewPageNotFoundItem model.activePage
    ]


viewPageNotFoundItem : Page -> Html Msg
viewPageNotFoundItem activePage =
    a
        [ classByPage PageNotFound activePage
        , onClick <| SetActivePage PageNotFound
        ]
        [ text "404 page" ]


viewMainContent : Model -> Html Msg
viewMainContent model =
    case model.activePage of
        Counter ->
            Html.map PageCounter (Pages.Counter.View.view model.pageCounter)

        PageNotFound ->
            -- We don't need to pass any cmds, so we can call the view directly
            Pages.PageNotFound.View.view


viewFooter : Html Msg
viewFooter =
    div
        [ class "ui inverted vertical footer segment form-page"
        ]
        [ div [ class "ui container" ]
            [ a
                [ href "http://gizra.com"
                , target "_blank"
                ]
                [ text "Gizra" ]
            , span [] [ text " // " ]
            , a
                [ href "https://github.com/Gizra/elm-spa-example"
                , target "_blank"
                ]
                [ text "Github" ]
            ]
        ]


{-| Get menu items classes. This function gets the active page and checks if
it is indeed the page used.
-}
classByPage : Page -> Page -> Attribute a
classByPage page activePage =
    classList
        [ ( "item", True )
        , ( "active", page == activePage )
        ]
