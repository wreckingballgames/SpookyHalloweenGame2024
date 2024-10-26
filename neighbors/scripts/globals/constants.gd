extends Node
## An autoload script to hold useful information for use across the entire game.

#region consts

## All the localization string tables to key into. Keep this parallel with
## the cultures enum.
const LOCALIZATION_STRING_TABLES: Dictionary = {
	cultures.default: "res://resources/localization/strings/default/default.tres",
}

## The cultures enum value to use based on the player's selected language.
# TODO: Implement culture selection for players and change this programmatically.
const CULTURE_SELECTED: cultures = cultures.default
## The filesystem path to xliff_paths.xml
const XLF_PATHS: String = "res://assets/xml/xliff_paths.xml"
## The filesystem path to where string Resources for localization are saved.
const STRING_RESOURCE_PATH: String = "res://resources/localization/strings/"

#endregion

#region enums

## All of the types of items usable by Characters in the game.
enum item_types {
	MEDKIT,
	KEY,
	DECOY,
	SHAPED_CHARGE,
}

## All of the rarities possible for items from most common to least common.
enum item_rarities {
	COMMON,
	UNCOMMON,
	RARE,
}

## All the useful combinations of collision layer bits.
enum collision_layer_bits {
	none = 0,
	environment = 1,
	players = 2,
	enemies = 4,
	pickups = 8,
	bullets = 16,
	players_and_enemies = players | enemies,
	environment_players_and_enemies = environment | players_and_enemies,
}

## All the cultures supported with localization string tables. The default is
## en.
enum cultures {
	default,
}

#endregion
