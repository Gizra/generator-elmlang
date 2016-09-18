module App.Update exposing (init, update, Msg(..))

import App.Model exposing (..)
import Pages.Counter.Update exposing (Msg)


type Msg
    = PageCounter Pages.Counter.Update.Msg
    | SetActivePage Page


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PageCounter msg ->
            let
                ( val, cmds ) =
                    Pages.Counter.Update.update msg model.pageCounter

                model' =
                    { model | pageCounter = val }
            in
                ( model', Cmd.map PageCounter cmds )

        SetActivePage page ->
            { model | activePage = page } ! []
