class_name Character
extends CharacterBody2D

@export var stats: PlayerStatistics
@export var starting_weapon: PackedScene

# Should only be modified by the character's associated controller!
var id: int
var direction: Vector2 = Vector2.ZERO
var target_position: Vector2 = Vector2.ZERO
var weapon_origin: Vector2
var equipped_weapon: Weapon


func _ready() -> void:
	weapon_origin = get_weapon_origin()
	equip_weapon(starting_weapon)


func _process(_delta: float) -> void:
	# TODO: Determine if this is good enough for character facing
	look_at(target_position)


func get_weapon_origin() -> Vector2:
	# TODO: determine if characters can ever have more than one weapon origin
	#   assume they won't for now. This code is easy to refactor if they do
	for node in get_children():
		var origin = node as WeaponOrigin
		if origin:
			return origin.global_position
	return global_position


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
