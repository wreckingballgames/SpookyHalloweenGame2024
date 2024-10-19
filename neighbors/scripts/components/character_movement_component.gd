class_name CharacterMovementComponent
extends Node

@export var character: Character

var modified_max_move_speed: float
var move_vector: Vector2
var current_move_speed: float


func _ready() -> void:
	EventBus.movement_dispatched.connect(_on_movement_dispatched)

	modified_max_move_speed = character.stats.base_max_move_speed


func _process(_delta: float) -> void:
	move()


# TODO
func move() -> void:
	# Calculate current_move_speed, which is added to when movement_dispatched
	#   goes off and which decays over time
	current_move_speed = modified_max_move_speed
	# Set character's velocity to current_move_speed
	move_vector *= current_move_speed
	character.velocity = move_vector
	set_direction()


func set_direction() -> void:
	character.direction = character.global_position + move_vector


func _on_movement_dispatched(id: int, movement_data: Vector2) -> void:
	if id != character.id:
		return
	move_vector = movement_data
