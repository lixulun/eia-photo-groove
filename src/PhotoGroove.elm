module PhotoGroove exposing (main)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


type alias Photo =
    { url : String
    }


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , div [ id "thumbnails" ]
            (List.map (viewThumbnail model.selectedUrl) model.photos)
        , img [ class "larger", src (urlPrefix ++ "large/" ++ model.selectedUrl) ] []
        ]


viewThumbnail selectedUrl thumb =
    img
        [ src (urlPrefix ++ thumb.url)
        , classList [ ( "selected", selectedUrl == thumb.url ) ]
        , onClick
            { description = "ClickedPhoto"
            , data = thumb.url
            }
        ]
        []


type alias Model =
    { photos : List Photo
    , selectedUrl : String
    }


initModel : Model
initModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedUrl = "1.jpeg"
    }


type alias Msg =
    { description : String
    , data : String
    }


update : Msg -> Model -> Model
update msg model =
    if msg.description == "ClickedPhoto" then
        { model | selectedUrl = msg.data }

    else
        model


main =
    Browser.sandbox
        { init = initModel
        , update = update
        , view = view
        }
