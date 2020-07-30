module Main exposing (..)

import Browser
import Browser.Dom as Dom exposing (Viewport)
import Cmd.Extra exposing (withNoCmd)
import Element
import Framework
import Framework.Heading as FH
import Html exposing (Html)
import List.Extra exposing (getAt)
import MyUI exposing (h1)
import Search
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
    , page : Page
    }


type Page
    = PageNewProject
    | PageMyProjects
    | PageSearch Search.Model


menus =
    [ ( PageNewProject, "Nouveau projet" )
    , ( PageMyProjects, "Mes projets" )
    , ( PageSearch Search.init, "Recherche de textes" )
    ]


menuSelectMsg : Int -> Maybe Msg
menuSelectMsg num =
    getAt num menus
        |> Maybe.andThen
            (\( page, _ ) -> Just <| ShowPage page)


menusAsSelect =
    { selected = Nothing
    , options =
        menus
            |> List.map Tuple.second
            |> List.map (\txt -> { text = txt, icon = Element.none })
    , onSelect = menuSelectMsg
    }


init : ( Model, Cmd Msg )
init =
    ( Loading
    , Task.perform GotViewport Dom.getViewport
    )



---- UPDATE ----


type Msg
    = GotViewport Viewport
    | ShowPage Page
    | ChangedSidebar (Maybe WL.Part)
    | SearchMsg Search.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( model, msg ) of
        ( Loading, GotViewport viewport ) ->
            Loaded
                { window = { width = viewport.viewport.width |> round, height = viewport.viewport.height |> round }
                , layout = WL.init
                , page = PageMyProjects
                }
                |> withNoCmd

        ( Loaded lmodel, ChangedSidebar mpart ) ->
            Loaded { lmodel | layout = WL.activate mpart lmodel.layout } |> withNoCmd

        ( Loaded lmodel, ShowPage page ) ->
            Loaded { lmodel | page = page } |> withNoCmd

        ( Loaded lmodel, SearchMsg smsg ) ->
            case lmodel.page of
                PageSearch smodel ->
                    Loaded { lmodel | page = PageSearch <| Search.update smsg smodel } |> withNoCmd

                _ ->
                    model |> withNoCmd

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
                , menu = menusAsSelect
                , search = Nothing
                , actions = []
                , onChangedSidebar = ChangedSidebar
                }
            <|
                Element.el [ Element.paddingXY 10 70, Element.height Element.fill, Element.width Element.fill ] <|
                    Element.el [] <|
                        viewPage loadedModel.page


viewPage : Page -> Element.Element Msg
viewPage page =
    case page of
        PageNewProject ->
            Element.none

        PageMyProjects ->
            h1 "Mes projets"

        PageSearch model ->
            Element.map SearchMsg <| Search.view model



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
