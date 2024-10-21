class_name CharacterMovementComponent
extends Node
## Component for moving characters.

## Reference to the component's associated character.
@export var character: Character

## Up-to-date maximum move speed value.
var modified_max_move_speed: float
## Vector representing the character's movement this frame.
var move_vector: Vector2
## Current move speed value.
var current_move_speed: float


func _ready() -> void:
	EventBus.movement_dispatched.connect(_on_movement_dispatched)

	modified_max_move_speed = character.stats.base_max_move_speed


# TODO
## Calculate the current rate of movement and apply to character.
func move() -> void:
	# Calculate current_move_speed, which is added to when movement_dispatched
	#   goes off and which decays over time
	current_move_speed = modified_max_move_speed
	# Set character's velocity to current_move_speed
	move_vector *= current_move_speed
	character.velocity = move_vector
	set_direction()


## Set the direction the character is facing to the direction they are moving in.
func set_direction() -> void:
	var new_direction: Vector2 = character.global_position.direction_to(character.global_position + move_vector)
	# Only set new direction if it is not zero, so Character facing is always
	# tracked correctly.
	if new_direction != Vector2.ZERO:
		character.direction = new_direction


func _on_movement_dispatched(id: int, movement_data: Vector2) -> void:
	if id != character.id:
		return
	move_vector = movement_data
	move()
