module App.Model exposing (emptyModel, Model, Page(..))

import Pages.Counter.Model exposing (emptyModel, Model)


type Page
    = Counter
    | PageNotFound


type alias Model =
    { activePage : Page
    , pageCounter : Pages.Counter.Model.Model
    }


emptyModel : Model
emptyModel =
    { activePage = Counter
    , pageCounter = Pages.Counter.Model.emptyModel
    }
