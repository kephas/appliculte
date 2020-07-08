module Main exposing (..)

import Browser
import Browser.Dom as Dom exposing (Viewport)
import Cmd.Extra exposing (withNoCmd)
import Element
import Framework
import Html exposing (Html)
import Task
import Widget.Layout as WL
import Widget.Style.Material as WSM



---- MODEL ----


type Model
    = Loading
    | Loaded LoadedModel


type alias LoadedModel =
    { window :
        { height : Int
        , width : Int
        }
    }


init : ( Model, Cmd Msg )
init =
    ( Loading
    , Task.perform GotViewport Dom.getViewport
    )



---- UPDATE ----


type Msg
    = GotViewport Viewport
    | SelectMenu Int
    | ChangedSidebar (Maybe WL.Part)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( model, msg ) of
        ( Loading, GotViewport viewport ) ->
            Loaded { window = { width = viewport.viewport.width |> round, height = viewport.viewport.height |> round } } |> withNoCmd

        _ ->
            model |> withNoCmd



---- VIEW ----


view : Model -> Html Msg
view model =
    case model of
        Loading ->
            Framework.responsiveLayout [] Element.none

        Loaded loadedModel ->
            WL.view (WSM.defaultPalette |> WSM.layout)
                { window = loadedModel.window
                , dialog = Nothing
                , layout = WL.init
                , title = Element.text "TITLE"
                , menu = { selected = Nothing, options = [], onSelect = \_ -> Nothing }
                , search = Nothing
                , actions = []
                , onChangedSidebar = ChangedSidebar
                }
            <|
                Element.text "content ?"



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
