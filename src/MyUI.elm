module MyUI exposing (..)

import Element as El
import Framework.Heading as FH
import Widget
import Widget.Style.Material as Material


fillWidth =
    El.width El.fill


h1 : String -> El.Element msg
h1 content =
    El.el FH.h1 <| El.text content


primaryButton =
    Material.containedButton Material.defaultPalette


expansionPanelStyle =
    Material.expansionPanel Material.defaultPalette


simpleColumn =
    Material.column


card =
    Widget.column (Material.cardColumn Material.defaultPalette)
