class_name CharacterMovementComponent
extends Node

@export var character: Character

var modified_max_move_speed: float
var current_move_speed: float


func _ready() -> void:
	modified_max_move_speed = character.stats.base_max_move_speed


# TODO
func move() -> void:
	# Calculate current_move_speed, which is added to when movement_dispatched
	#   goes off and which decays over time
	# Set character's velocity to current_move_speed
	pass
