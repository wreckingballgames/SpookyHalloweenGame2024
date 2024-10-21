class_name PlayerCharacter
extends Character
## The class used for all player characters in the game.


func _process(_delta: float) -> void:
	super(_delta)

	move_and_slide()
	set_target_position_to_direction()


## Set target position to the direction the player is facing.
func set_target_position_to_direction() -> void:
	target_position = global_position + direction
