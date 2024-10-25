extends Node
## An autoload script to hold useful information for use across the entire game.

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
	en,
}

## The filesystem path to xliff_paths.xml
const XLF_PATHS: String = "res://assets/xml/xliff_paths.xml"
## The filesystem path to where string Resources for localization are saved.
const STRING_RESOURCE_PATH: String = "res://resources/localization/strings/"
