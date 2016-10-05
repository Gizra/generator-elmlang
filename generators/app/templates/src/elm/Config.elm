module Config exposing (..)

import Config.Model as Config exposing (Model)
import Time exposing (Time)


localBackend : Model
localBackend =
    { backendUrl = "https://api.github.com"
    , name = "local"
    , hostname = "localhost"
    }


prodBackend : Model
prodBackend =
    { backendUrl = "https://api.github.com"
    , name = "gh-pages"
    , hostname = "example.com"
    }


backends : List Model
backends =
    [ localBackend
    , prodBackend
    ]


cacheTtl : Time.Time
cacheTtl =
    (5 * Time.second)
