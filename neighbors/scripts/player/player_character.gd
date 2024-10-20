class_name PlayerCharacter
extends Character
## The class used for all player characters in the game.


func _process(_delta: float) -> void:
	super(_delta)

	set_target_position_to_direction()
	move_and_slide()


## Set target position to the direction the player is facing.
func set_target_position_to_direction() -> void:
	target_position = direction
