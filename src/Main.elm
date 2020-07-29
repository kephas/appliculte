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
    , layout : WL.Layout Msg
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
            Loaded
                { window = { width = viewport.viewport.width |> round, height = viewport.viewport.height |> round }
                , layout = WL.init
                }
                |> withNoCmd

        ( Loaded lmodel, ChangedSidebar mpart ) ->
            Loaded { lmodel | layout = WL.activate mpart lmodel.layout } |> withNoCmd

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
                , layout = loadedModel.layout
                , title = Element.text "AppliCulte"
                , menu = { selected = Nothing, options = List.map (\txt -> { text = txt, icon = Element.none }) [ "Nouveau projet", "Mes projets", "Recherche de textes" ], onSelect = \num -> Just <| SelectMenu num }
                , search = Nothing
                , actions = []
                , onChangedSidebar = ChangedSidebar
                }
            <|
                Element.el [ Element.paddingXY 10 70, Element.height Element.fill, Element.width Element.fill ] <|
                    Element.el [] <|
                        Element.text "content goes here"



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
