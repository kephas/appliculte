module Texts exposing (..)


type alias LiturgicText =
    { title : Maybe String
    , content : String
    , source : String
    , type_ : String
    , moment : String
    , time : Maybe String
    }


texts : List LiturgicText
texts =
    [ { title = Nothing
      , content = """Dieu nous rassemble.
Il est notre créateur,
et nous vivons dans la liberté de ses enfants.
Il est la paix,
et par lui nous pouvons vivre
réconciliés les uns avec les autres."""
      , source = "Liturgie Rouge"
      , type_ = "Prière"
      , moment = "Parole d’accueil"
      , time = Nothing
      }
    , { title = Nothing
      , content = """Une voix crie dans le désert :
« Préparez le chemin du Seigneur,
rendez droits ses sentiers. »
Ensemble,
préparons-nous à la venue de Jésus Christ,
qui est le chemin, la vérité et la vie."""
      , source = "Liturgie Rouge"
      , type_ = "Prière"
      , moment = "Parole d'accueil"
      , time = Just "Avent"
      }
    ]
