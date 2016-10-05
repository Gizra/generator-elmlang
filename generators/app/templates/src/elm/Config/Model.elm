module Config.Model exposing (..)


type alias BackendUrl =
    String


type alias Model =
    { backendUrl : BackendUrl
    , hostname : String
    , name : String
    }
