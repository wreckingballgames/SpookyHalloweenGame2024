class_name SurvivorStatistics
extends Resource
## The Resource which determines all of a Survivor's unique attributes.

## The keys (property names) for all the Survivor's strings.
const STRING_KEYS: Dictionary = {
	survivor_strings.randy_name: Constants.STRINGS.randy_name,
}

## All the keys for Weapon strings from STRINGS.
enum survivor_strings {
	randy_name,
}

@export var name_key: survivor_strings
## The survivor's in-game graphical representation.
@export var sprite: Texture
## How much score the survivor is worth when collected by players.
@export var score_value: int

## The survivor's name.
# TODO: figure out where to set this, right now it is never set (though also
# never used). See also TODO in CharacterInventoryComponent for
# WeaponStatistics name.
var name: String
