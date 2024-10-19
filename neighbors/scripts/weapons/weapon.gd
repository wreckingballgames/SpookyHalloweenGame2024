class_name Weapon
extends Node2D

@export var stats: WeaponStatistics

var character: Character
var ammo_count: int

# This script is used on more than one object
# Ensure these objects exist with default, unique names
@onready var sprite_2d: Sprite2D = %Sprite2D


func _ready() -> void:
	EventBus.attack_performed.connect(_on_attack_performed)

	sprite_2d.texture = stats.sprite
	ammo_count = stats.ammo_capacity


# TODO
func _on_attack_performed(id: int) -> void:
	if id != character.id:
		return
	# Spawn bullet and set it up (including passing character info and weapon info on)
	# Bullet does its thing
