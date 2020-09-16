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
    , { title = Nothing
      , content = """Seigneur,
tu as dit : « Là où deux ou trois
se rassemblent en mon nom,
je suis au milieu d’eux. »
Merci pour cette promesse :
qu’elle se réalise maintenant pour nous
lorsque nous sommes rassemblés
pour te louer et écouter ta Parole.
Toi, notre seule espérance,
tu es béni pour les siècles des siècles.
l’assemblée : Amen."""
      , source = "Liturgie Rouge"
      , type_ = "Prière"
      , moment = "Parole de Dieu"
      , time = Nothing
      }
    , { title = Nothing
      , content = """Dieu notre Père,
vers toi monte notre reconnaissance pour cette communion :
en venant à nous, le Christ Jésus
nous donne part à sa victoire sur le mal et sur la mort.
Loué sois-tu, Dieu béni pour les siècles des siècles !
l’assemblée : Amen."""
      , source = "Liturgie Rouge"
      , type_ = "Prière"
      , moment = "Parole d'action de grâce"
      , time = Nothing
      }
    , { title = Nothing
      , content = """Dieu notre Père,
sois béni pour cette communion
qui nous aide à demeurer en éveil
dans l’attente de ton Royaume.
Revêtus de ta grâce, nous pourrons participer
au festin des noces de l’Agneau.
Loué sois-tu pour les siècles des siècles.
l’assemblée : Amen."""
      , source = "Liturgie Rouge"
      , type_ = "Prière"
      , moment = "Parole d'action de grâce"
      , time = Just "Avent"
      }
    ]
