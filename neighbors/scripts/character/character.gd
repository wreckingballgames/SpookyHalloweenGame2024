class_name Character
extends CharacterBody2D
## The base class for all characters in the game. This should be extended before creating a new Character scene.

## The character's unique attributes.
@export var stats: CharacterStatistics
## The weapon the character begins play equipped with.
@export var starting_weapon: WeaponStatistics
## The item the character begins play equipped with, if any.
@export var starting_item: Item
## The amount of the starting item to start with, if any.
@export var starting_item_amount: int

## The character's unique identifier. This should only be modified by the character's CharacterController.
var id: int
## The direction the character is facing.
var direction := Vector2.ZERO
## The position the character is "focused" on. Most characters look at this position and most enemies move toward it.
var target_position := Vector2.ZERO
## The location of the character's weapon.
var weapon_origin: Vector2
## A reference to the Character's currently equipped weapon.
var equipped_weapon: Weapon
## The type of item the Character currently has equipped.
var equipped_item: Constants.item_types


func _ready() -> void:
	weapon_origin = get_weapon_origin()
	# Sounds really dumb, but handles _ready() order problem when setting
	# position.
	equip_weapon(equipped_weapon)


func _process(_delta: float) -> void:
	# TODO: Determine if this is good enough for character facing
	look_at(target_position)


## Returns the location where the character's weapon should be placed or the Character's origin if no valid WeaponOrigin is found.
func get_weapon_origin() -> Vector2:
	# TODO: determine if characters can ever have more than one weapon origin
	#   assume they won't for now. This code is easy to refactor if they do
	for node in get_children():
		var origin = node as WeaponOrigin
		if origin:
			return origin.position
	return Vector2.ZERO


## Equip designated weapon.
func equip_weapon(weapon: Weapon) -> void:
	equipped_weapon = weapon
	equipped_weapon.position = weapon_origin
	equipped_weapon.show()


## Unequip currently equipped weapon.
func unequip_weapon() -> void:
	if equipped_weapon:
		equipped_weapon.hide()


## Equip designated type of item.
func equip_item(item_type: Constants.item_types) -> void:
	equipped_item = item_type
