module Counter where

import Effects exposing (Effects)
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


-- MODEL

type alias Model = Int

initialModel : Model
initialModel = 0

init : (Model, Effects Action)
init =
  ( initialModel
  , Effects.none
  )


-- UPDATE

type Action = Decrement | Increment

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Decrement ->
      ( model - 1
      , Effects.none
      )
          
    Increment ->
      ( model + 1
      , Effects.none
      )



-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ button [ onClick address Decrement ] [ text "-" ]
    , div [ countStyle ] [ text (toString model) ]
    , button [ onClick address Increment ] [ text "+" ]
    ]


countStyle : Attribute
countStyle =
  style
    [ ("font-size", "20px")
    , ("font-family", "monospace")
    , ("display", "inline-block")
    , ("width", "50px")
    , ("text-align", "center")
    ]
