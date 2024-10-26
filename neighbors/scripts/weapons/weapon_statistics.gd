class_name WeaponStatistics
extends Resource
## The Resource which determines all of a Weapon's unique attributes.

## The keys (property names) for all the Weapon's strings.
const STRING_KEYS: Dictionary = {
	weapon_strings.machine_pistol_name: Constants.STRINGS.machine_pistol_name,
	weapon_strings.weed_whacker_name: Constants.STRINGS.weed_whacker_name,
}

## All the keys for Weapon strings from STRINGS.
enum weapon_strings {
	machine_pistol_name,
	weed_whacker_name,
}

## The key to get the Weapon's human-readable name.
@export var name_key: weapon_strings
## In-game texture.
@export var sprite: Texture
## UI texture.
@export var icon: Texture
## The template used to spawn bullets. Only put bullet scenes here.
@export var bullet_template: PackedScene
## The maximum ammo Character's can hold for this Weapon. Set to 0 for melee weapons or weapons with infinite ammo.
@export var ammo_capacity: int = 0
## The rate at which Weapons can spawn bullets in actions per second. Set to 0 for constant attacks.
@export var attack_rate: int = 1

var name: String
