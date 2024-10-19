class_name CharacterController
extends Node
## The base class for all character controllers. Extend before using. A controller is an authoritative source of input handling for Characters.

## Reference to the controller's associated character.
@export var character: Character

## Unique identifier, generated in collaboration with the multiplayer object.
var id: int:
	set(value):
		id = value
		character.id = value
		EventBus.id_set.emit(value)


func _ready() -> void:
	# TODO: Collaborate with multiplayer object to generate a unique id for this player
	id = 2
