module Search exposing (..)

import Element as El
import Element.Input as In
import Element.Region as Reg
import MyUI exposing (card, expansionPanelStyle, fillWidth, h1, primaryButton)
import Set
import Widget


type alias Model =
    { expression : String
    , advanced : Bool
    , sources : Set.Set String
    , types : Set.Set String
    , moments : Set.Set String
    }


init : Model
init =
    { expression = ""
    , advanced = True
    , sources = Set.empty
    , types = Set.empty
    , moments = Set.empty
    }


sources =
    [ "Ancien Testament", "Nouveau Testament", "Apocryphes", "Sources anciennes", "Cantiques", "Prières", "Textes personnels" ]


types =
    [ "Prière", "Chant", "Psaume", "Cantique", "Texte biblique", "Parabole" ]


moments =
    [ "Entrée", "Parole de Dieu", "Repas du Seigneur", "Bénédiction d'envoi" ]


temps =
    [ "Avent", "Noël", "Épiphanie", "pré-Carême", "Carême", "Pâques", "Pentecôte", "Trinité", "Fêtes particulières" ]


type Msg
    = ChangeExpression String
    | ToggleAdvanced Bool
    | ToggleSource String Bool
    | ToggleType String Bool
    | ToggleMoment String Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeExpression expr ->
            { model | expression = expr }

        ToggleAdvanced toggled ->
            { model | advanced = toggled }

        ToggleSource source selected ->
            if selected then
                { model | sources = Set.insert source model.sources }

            else
                { model | sources = Set.remove source model.sources }

        ToggleType type_ selected ->
            if selected then
                { model | types = Set.insert type_ model.types }

            else
                { model | types = Set.remove type_ model.types }

        ToggleMoment moment selected ->
            if selected then
                { model | moments = Set.insert moment model.moments }

            else
                { model | moments = Set.remove moment model.moments }



--choiceInput : Foo


choiceInput message selector model choice =
    In.checkbox []
        { onChange = message choice
        , icon = In.defaultCheckbox
        , checked = model |> selector |> Set.member choice
        , label = In.labelRight [] <| El.text choice
        }


choicesInputs message selector model choices =
    El.column [ El.spacing 20 ] <|
        List.map (choiceInput message selector model) choices


viewAdvancedSearch : Model -> El.Element Msg
viewAdvancedSearch model =
    El.row [ El.width El.fill, El.spacing 40 ]
        [ card
            [ h1 "Source"
            , choicesInputs ToggleSource .sources model sources
            ]
        , card
            [ h1 "Type"
            , choicesInputs ToggleType .types model types
            ]
        , card
            [ h1 "Moment liturgique"
            , choicesInputs ToggleMoment .moments model moments
            ]
        ]


view : Model -> El.Element Msg
view model =
    El.column [ El.width El.fill, El.padding 10, El.spacing 20 ]
        [ h1 "Recherche"
        , El.el [ Reg.mainContent ] <|
            El.row [ El.spacing 40, fillWidth ]
                [ In.search [ fillWidth ]
                    { onChange = ChangeExpression
                    , text = model.expression
                    , placeholder = Just <| In.placeholder [] <| El.text "Termes à rechercher"
                    , label = In.labelHidden "Recherche"
                    }
                , Widget.textButton primaryButton
                    { text = "Rechercher"
                    , onPress = Nothing
                    }
                ]
        , Widget.expansionPanel expansionPanelStyle
            { onToggle = ToggleAdvanced
            , icon = El.none
            , text = "Recherche avancée"
            , content = viewAdvancedSearch model
            , isExpanded = model.advanced
            }
        ]
