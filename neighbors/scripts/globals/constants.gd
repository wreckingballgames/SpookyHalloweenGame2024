extends Node
## An autoload script to hold useful information for use across the entire game.

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

## Value of environment collision layer bits.
const ENVIRONMENT_COLLISION_LAYER: int = 1
## Value of players collision layer bits.
const PLAYERS_COLLISION_LAYER: int = 2
## Value of enemies collision layer bits.
const ENEMIES_COLLISION_LAYER: int = 4
## Value of pickups collision layer bits.
const PICKUPS_COLLISION_LAYER: int = 8
## Value of bullets collision layer bits.
const BULLETS_COLLISION_LAYER: int = 16
