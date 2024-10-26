class_name SurvivorStatistics
extends Resource
## The Resource which determines all of a Survivor's unique attributes.

## The survivor's in-game graphical representation.
@export var sprite: Texture
## How much score the survivor is worth when collected by players.
@export var score_value: int

## The localization string table to pull human-readable strings from.
const STRINGS: LocalizationStringTable = preload(Constants.LOCALIZATION_STRING_TABLES[Constants.CULTURE_SELECTED])
## The survivor's name.
var name: String
