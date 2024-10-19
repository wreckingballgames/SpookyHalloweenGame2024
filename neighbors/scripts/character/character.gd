class_name Character
extends CharacterBody2D

@export var starting_weapon: Weapon

# Should only be modified by the character's associated controller!
var id: int
var direction: Vector2 = Vector2.ZERO
var target_position: Vector2 = Vector2.ZERO

@export var stats: PlayerStatistics


func _process(_delta: float) -> void:
	# TODO: Determine if this is good enough for character facing
	look_at(target_position)
