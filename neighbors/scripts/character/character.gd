class_name Character
extends CharacterBody2D
## The base class for all characters in the game. This should be extended before creating a new Character scene.

## The character's unique attributes.
@export var stats: CharacterStatistics
## The weapon the character begins play equipped with.
@export var starting_weapon: PackedScene

## The character's unique identifier. This should only be modified by the character's CharacterController.
var id: int
## The direction the character is facing.
var direction: Vector2 = Vector2.ZERO
## The position the character is "focused" on. Most characters look at this position and most enemies move toward it.
var target_position: Vector2 = Vector2.ZERO
## The location of the character's weapon.
var weapon_origin: Vector2
## A reference to the player's currently equipped weapon.
var equipped_weapon: Weapon


func _ready() -> void:
	weapon_origin = get_weapon_origin()
	equip_weapon(starting_weapon)


func _process(_delta: float) -> void:
	# TODO: Determine if this is good enough for character facing
	look_at(target_position)


## Returns the location where the character's weapon should be placed or the character's position if no valid WeaponOrigin is found.
func get_weapon_origin() -> Vector2:
	# TODO: determine if characters can ever have more than one weapon origin
	#   assume they won't for now. This code is easy to refactor if they do
	for node in get_children():
		var origin = node as WeaponOrigin
		if origin:
			return origin.global_position
	return global_position


## Unequip the character's previous weapon, if any, and equip a new one.
func equip_weapon(weapon: PackedScene) -> void:
	# Unequip previous weapon
	if equipped_weapon:
		remove_child.call_deferred(equipped_weapon)
	# Instantiate weapon
	equipped_weapon = weapon.instantiate() as Weapon
	equipped_weapon.character = self
	# Add weapon as child
	add_child(equipped_weapon, true)
	# Set weapon position to character's hand coordinates
	equipped_weapon.global_position = weapon_origin
